package ru.job4j.cinema.servlet;

import com.google.gson.Gson;
import ru.job4j.cinema.model.Place;
import ru.job4j.cinema.store.PsqlStore;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * @author madrabit on 02.06.2020
 * @version 1$
 * @since 0.1
 * Cinema hall.
 */
public class HallServlet extends HttpServlet {
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    /**
     * Returns all seats from db with JSON.
     *
     * @param req
     * @param resp
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
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
