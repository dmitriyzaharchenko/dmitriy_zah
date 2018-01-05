package ua.nure.zaharchenko.transaction;

import java.sql.Connection;


public class ConnectionManager {
    private static ThreadLocal<Connection> threadLocal = new ThreadLocal<>();

    public static Connection getConnection() {
        return threadLocal.get();
    }

    public static void setConnection(Connection connection) {
        threadLocal.set(connection);
    }

}
