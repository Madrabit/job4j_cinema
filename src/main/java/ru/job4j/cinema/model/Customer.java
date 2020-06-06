package ru.job4j.cinema.model;

import java.util.Map;
import java.util.Objects;

/**
 * @author madrabit on 28.05.2020
 * @version 1$
 * @since 0.1
 */
public class Customer {
    private int id;
    private String name;
    private int phone;

    public Customer(String name, int phone) {
        this.name = name;
        this.phone = phone;
    }

    public Customer(int id, String name, int phone) {
        this.id = id;
        this.name = name;
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Customer customer = (Customer) o;
        return phone == customer.phone &&
                Objects.equals(name, customer.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, phone);
    }

    @Override
    public String toString() {
        return "Customer{" +
                "name='" + name + '\'' +
                ", phone=" + phone +
                '}';
    }


}
