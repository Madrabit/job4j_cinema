package ru.job4j.cinema.store;

import ru.job4j.cinema.model.Customer;
import ru.job4j.cinema.model.Place;

import java.util.List;

/**
 * @author madrabit on 28.05.2020
 * @version 1$
 * @since 0.1
 */
public interface Store {
    List<Place> findAllPlaces ();

    List<Customer> findAllCustomers();

    void makePurchase(Customer customer, List<String> seats);
}
