package ua.nure.zaharchenko.transaction;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;



public class TransactionalPool {

    private DataSource dataSource;

    public TransactionalPool(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public <T> T execute(Transaction<T> transaction) {
        Connection connection = null;
        T result = null;
        try {
            connection = dataSource.getConnection();
            connection.setAutoCommit(false);
            ConnectionManager.setConnection(connection);
            result = transaction.execute();
            connection.commit();
        } catch (SQLException e) {
            rollbackConnection(connection);
        } finally {
            closeConnection(connection);
        }
        return result;
    }

    private void closeConnection(Connection connection) {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException ignore) {
        }
    }

    private void rollbackConnection(Connection connection) {
        try {
            if (connection != null) {
                connection.rollback();
            }
        } catch (SQLException ignore) {
        }
    }

}
