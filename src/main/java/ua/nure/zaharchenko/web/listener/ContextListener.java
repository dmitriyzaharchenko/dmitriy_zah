package ua.nure.zaharchenko.web.listener;

import ua.nure.zaharchenko.DAO.UserDAO;
import ua.nure.zaharchenko.DAO.mysql.UserDAOImpl;
import ua.nure.zaharchenko.transaction.TransactionalPool;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.sql.DataSource;


@WebListener
public class ContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext ctx = servletContextEvent.getServletContext();

        TransactionalPool transactionalPool = new TransactionalPool(getDataSource());
        UserDAO userDAO = new UserDAOImpl();



       // UserService userService = new UserServiceImpl(userDAO, transactionalPool);
        //LoginService loginService = new LoginServiceImpl();
        //RegistrationService registrationService = new RegistrationService(captchaHandler);

        ctx.setAttribute("tr", transactionalPool);
        //ctx.setAttribute(Parameters.PRODUCT_SERVICE, productService);
        //ctx.setAttribute(Parameters.LOGIN_SERVICE, loginService);
        //ctx.setAttribute(Parameters.REG_SERVICE, registrationService);
        //checkImageDirectory(ctx);
    }
    private DataSource getDataSource() {
        DataSource ds;
        try {
            Context initialContext = new InitialContext();
            ds = (DataSource) initialContext.lookup("java:comp/env/jdbc/root");
        } catch (NamingException e) {
            throw new IllegalStateException("DataSource init error", e);
        }
        return ds;
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
