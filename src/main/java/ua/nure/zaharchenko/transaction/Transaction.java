package ua.nure.zaharchenko.transaction;


public interface Transaction<T> {
    T execute();
}
