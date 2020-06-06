package ru.job4j.cinema.model;

import java.util.Objects;

/**
 * @author madrabit on 28.05.2020
 * @version 1$
 * @since 0.1
 */
public class Place {
    private int id;
    private int row;
    private int place;
    private int price;
    private boolean busy;

    public Place(int id, int row, int place, int price, boolean busy) {
        this.id = id;
        this.row = row;
        this.place = place;
        this.price = price;
        this.busy = busy;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRow() {
        return row;
    }

    public void setRow(int row) {
        this.row = row;
    }

    public int getPlace() {
        return place;
    }

    public void setPlace(int place) {
        this.place = place;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public boolean isBusy() {
        return busy;
    }

    public void setBusy(boolean busy) {
        this.busy = busy;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Place place1 = (Place) o;
        return id == place1.id &&
                row == place1.row &&
                place == place1.place &&
                price == place1.price;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, row, place, price);
    }

    @Override
    public String toString() {
        return "Place{" +
                "id=" + id +
                ", row=" + row +
                ", place=" + place +
                ", price=" + price +
                ", occupy=" + busy +
                '}';
    }
}
