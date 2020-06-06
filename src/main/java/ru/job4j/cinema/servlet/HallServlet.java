package ru.job4j.cinema.servlet;

import com.google.gson.Gson;
import org.json.JSONObject;
import ru.job4j.cinema.model.Place;
import ru.job4j.cinema.store.PsqlStore;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author madrabit on 02.06.2020
 * @version 1$
 * @since 0.1
 */
public class HallServlet extends HttpServlet {
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Place> places = PsqlStore.instOf().findAllPlaces();
        HallServlet.JsonObj jsonObj = new HallServlet.JsonObj(places);
        String jsonString = this.gson.toJson(jsonObj);
        PrintWriter out = resp.getWriter();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        out.print(jsonString);
        out.flush();
    }

    public static class JsonObj {
        private final List<Place> busyPlaces;

        public JsonObj(List<Place> busyPlaces) {
            this.busyPlaces = busyPlaces;
        }
    }
}
