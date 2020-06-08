package ru.job4j.cinema.store;

import ru.job4j.cinema.model.Customer;

import java.util.ArrayList;
import java.util.List;

/**
 * @author madrabit on 28.05.2020
 * @version 1$
 * @since 0.1
 */
public class PsqlMain {
    public static void main(String[] args) {

        Store store = PsqlStore.instOf();

        List<String> list = new ArrayList<>();
        store.makePurchase(new Customer("Mr Twister111123123123", 3222233), list);
        List<Customer> customers = store.findAllCustomers();

        for (Customer customer : customers) {
            System.out.println(customer.getName());
        }

    }
}
