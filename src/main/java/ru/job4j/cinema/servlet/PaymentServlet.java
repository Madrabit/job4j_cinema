package ru.job4j.cinema.servlet;

import org.json.JSONArray;
import org.json.JSONObject;
import ru.job4j.cinema.model.Customer;
import ru.job4j.cinema.store.PsqlStore;

import javax.servlet.ServletException;
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
 * Payment servlet.
 */
public class PaymentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {

    }

    /**
     * Get name, phone, seats and send it to database.
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/json");
        String jb;
        try (BufferedReader reader = request.getReader()) {
            jb = reader.lines().collect(Collectors.joining());
        }
        String name = "";
        String phone = "";
        JSONArray seatsJson;
        List<String> seats = new ArrayList<>();
        if (!jb.isEmpty()) {
            JSONObject jObj = new JSONObject(jb);
            name = (String) jObj.get("name");
            phone = (String) jObj.get("phone");
            seatsJson = (JSONArray) jObj.get("seats");
            if ((name == null || name.isEmpty())
                    || (phone == null || phone.isEmpty())
                    || (seatsJson == null || seatsJson.isEmpty())
            ) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
            for (Object o : Objects.requireNonNull(seatsJson)) {
                seats.add((String) o);
            }
        }

        PsqlStore.instOf().makePurchase(
                new Customer(
                        name,
                        Integer.parseInt(Objects.requireNonNull(phone))
                ),
                seats
        );
    }
}
