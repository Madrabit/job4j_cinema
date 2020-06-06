package ru.job4j.cinema.store;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import ru.job4j.cinema.model.Customer;
import ru.job4j.cinema.model.Place;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

/**
 * @author madrabit on 02.06.2020
 * @version 1$
 * @since 0.1
 */
public class PsqlStore implements Store {

    private static final Logger LOG = LogManager.getLogger(PsqlStore.class.getName());

    private static final BasicDataSource pool = new BasicDataSource();

    PsqlStore() {
        Properties cfg = new Properties();
        try (BufferedReader io = new BufferedReader(
                new FileReader("db.properties")
        )) {
            cfg.load(io);
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
        try {
            Class.forName(cfg.getProperty("jdbc.driver"));
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
        pool.setDriverClassName(cfg.getProperty("jdbc.driver"));
        pool.setUrl(cfg.getProperty("jdbc.url"));
        pool.setUsername(cfg.getProperty("jdbc.username"));
        pool.setPassword(cfg.getProperty("jdbc.password"));
        pool.setMinIdle(5);
        pool.setMaxIdle(10);
        pool.setMaxOpenPreparedStatements(100);
        createTables();
    }

    private void createTables() {
        try (BufferedReader br = new BufferedReader(
                new FileReader("db" + File.separator + "schema_cinema.sql"))) {
            String line;
            try (Connection cn = pool.getConnection();
                 Statement st = cn.createStatement()) {
                while ((line = br.readLine()) != null) {
                    st.execute(line);
                }
            }
        } catch (Exception ex) {
            throw new IllegalStateException(ex);
        }
    }

    private static final class Lazy {
        private static final Store INST = new PsqlStore();
    }

    public static Store instOf() {
        return Lazy.INST;
    }

    @Override
    public List<Place> findAllPlaces() {
        List<Place> places = new LinkedList<>();
        try (Connection cn = pool.getConnection();
             PreparedStatement ps = cn.prepareStatement("SELECT * FROM halls")
        ) {
            try (ResultSet it = ps.executeQuery()) {
                while (it.next()) {
                    places.add(
                            new Place(
                                    it.getInt("id"),
                                    it.getInt("row"),
                                    it.getInt("place"),
                                    it.getInt("price"),
                                    it.getBoolean("busy")
                            ));

                }
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        return places;
    }

    @Override
    public List<Customer> findAllCustomers() {
        List<Customer> customers = new LinkedList<>();
        try (Connection cn = pool.getConnection();
             PreparedStatement ps = cn.prepareStatement("SELECT * FROM accounts")
        ) {
            try (ResultSet it = ps.executeQuery()) {
                while (it.next()) {
                    customers.add(
                            new Customer(
                                    it.getInt("id"),
                                    it.getString("name"),
                                    it.getInt("phone")
                            ));

                }
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
        return customers;
    }
    @Override
    public void makePurchase(Customer customer, List<String> seats) {
        try (Connection cn = pool.getConnection();
             PreparedStatement ps = cn.prepareStatement("INSERT INTO accounts(name, phone) VALUES (?, ?)", PreparedStatement.RETURN_GENERATED_KEYS)
        ) {
            ps.setString(1, customer.getName());
            ps.setInt(2, customer.getPhone());
            ps.execute();
            try (ResultSet id = ps.getGeneratedKeys()) {
                if (id.next()) {
                    customer.setId(id.getInt(1));
                }
            }
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
        }
    }
}
