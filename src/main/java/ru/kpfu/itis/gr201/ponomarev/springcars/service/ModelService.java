package ru.kpfu.itis.gr201.ponomarev.springcars.service;

import ru.kpfu.itis.gr201.ponomarev.springcars.exception.SaveException;

public interface ModelService {
    int saveIfNotExists(String make, String model) throws SaveException;
}
