package ua.nure.zaharchenko.DAO;

import ua.nure.zaharchenko.entity.User;


public interface UserDAO {
    User getByLoginAndPassword(String login, String password);
    void create(User user);
    void update(User user);
}
