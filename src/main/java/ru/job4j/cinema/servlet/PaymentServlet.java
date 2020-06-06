package ru.job4j.cinema.servlet;

import com.google.gson.Gson;
import org.apache.commons.fileupload.FileItem;
import org.json.JSONObject;
import ru.job4j.cinema.model.Customer;
import ru.job4j.cinema.model.Place;
import ru.job4j.cinema.store.PsqlStore;
import ru.job4j.cinema.store.Store;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author madrabit on 03.06.2020
 * @version ${Id}$
 * @since 0.1
 */
public class PaymentServlet extends HttpServlet {
    private final Gson gson = new Gson();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/json");
        String jb;
        try (BufferedReader reader = request.getReader()) {
            jb = reader.lines().collect(Collectors.joining());
        }
        String name = "";
        String phone = "";
        if (!jb.isEmpty()) {
            JSONObject jObj = new JSONObject(jb);
            name = (String) jObj.get("name");
            phone = (String) jObj.get("phone");
        }
        List<String> seats = new LinkedList<>();
        int price = 0;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().startsWith("ticket-")) {
                    String seat = cookie.getValue();
//                    String[] seatArr = seat.split("\\.");
                    seats.add(seat);
                }
            }
        }
        Store store = PsqlStore.instOf();

//        List list = new ArrayList<>();
//        store.makePurchase(new Customer("Mr asd", 111111), list);

        PsqlStore.instOf().makePurchase(
                new Customer(
                        name,
                        Integer.parseInt(phone)
                ),
                seats
        );

        List<Customer> customers = PsqlStore.instOf().findAllCustomers();

        for (Customer customer : customers) {
            System.out.println("This form database: " + customer.getName());
        }

    }
}
