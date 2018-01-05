package ua.nure.zaharchenko.DAO.mysql;


import ua.nure.zaharchenko.DAO.UserDAO;
import ua.nure.zaharchenko.entity.User;
import ua.nure.zaharchenko.transaction.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAOImpl implements UserDAO {
    private static final String CREATE_USER = "INSERT INTO user (`name`,`surname`,`phone`,`email`, `login`, `password`) VALUES(?,?,?,?,?,?)";
    private static final String GET_USER_BY_LOGIN_AND_PASS = "SELECT * FROM hotel.user WHERE login=? AND password=?";
    private static final String UPDATE_USER = "UPDATE user SET phone=?, email=?, login=?, name=?, surname=?, password=? where id=?";

    @Override
    public User getByLoginAndPassword(String login, String password) {
        Connection connection = ConnectionManager.getConnection();

        User user = null;
        try (PreparedStatement ps = connection.prepareStatement(GET_USER_BY_LOGIN_AND_PASS)) {

            ps.setString(1, login);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = extractUser(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public void create(User user) {
        Connection connection = ConnectionManager.getConnection();

        try (PreparedStatement ps = connection.prepareStatement(CREATE_USER, PreparedStatement.RETURN_GENERATED_KEYS)) {

            int k = 1;
            ps.setString(++k, user.getName());
            ps.setString(++k, user.getSurname());
            ps.setString(++k, user.getPhone());
            ps.setString(++k, user.getEmail());
            ps.setString(++k, user.getLogin());
            ps.setString(++k, user.getPassword());
            user.setId(ps.executeUpdate());

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void update(User user) {
        Connection connection = ConnectionManager.getConnection();

        try (PreparedStatement ps = connection.prepareStatement(UPDATE_USER)) {

            int k = 1;
            ps.setString(++k, user.getPhone());
            ps.setString(++k, user.getEmail());
            ps.setString(++k, user.getLogin());
            ps.setString(++k, user.getName());
            ps.setString(++k, user.getSurname());
            ps.setString(++k, user.getPassword());
            ps.setInt(++k, user.getId());

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //util
    private User extractUser(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setId(resultSet.getInt("id"));
        user.setEmail(resultSet.getString("email"));
        user.setPassword(resultSet.getString("password"));
        user.setName(resultSet.getString("name"));
        user.setSurname(resultSet.getString("surname"));
        user.setPhone(resultSet.getString("phone"));
        user.setLogin(resultSet.getString("login"));
        return user;
    }

}

