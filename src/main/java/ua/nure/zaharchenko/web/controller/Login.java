package ua.nure.zaharchenko.web.controller;


import ua.nure.zaharchenko.DAO.UserDAO;
import ua.nure.zaharchenko.DAO.mysql.UserDAOImpl;
import ua.nure.zaharchenko.entity.User;
import ua.nure.zaharchenko.transaction.TransactionalPool;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class Login extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("login");
        String password = req.getParameter("pass");
        TransactionalPool tp = (TransactionalPool) getServletContext().getAttribute("tr");
        UserDAO userDAO = new UserDAOImpl();
        User user = tp.execute(() -> userDAO.getByLoginAndPassword(login, password));
        if (user != null) req.getSession().setAttribute("user", user);
        resp.sendRedirect("/main");
    }
}