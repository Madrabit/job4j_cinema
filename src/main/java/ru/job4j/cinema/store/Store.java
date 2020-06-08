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
    /**
     * Return all seat of hall.
     *
     * @return List of seats.
     */
    List<Place> findAllPlaces();

    /**
     * Return all customers with already payed.
     *
     * @return List of customers.
     */
    List<Customer> findAllCustomers();

    /**
     * Add customer and block seats.
     *
     * @param customer Customer who payed.
     * @param seats    Chosen seats.
     */
    void makePurchase(Customer customer, List<String> seats);
}
