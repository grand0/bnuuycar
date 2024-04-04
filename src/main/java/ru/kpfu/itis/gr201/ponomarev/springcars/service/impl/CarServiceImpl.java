package ru.kpfu.itis.gr201.ponomarev.springcars.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.CarDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.SaveException;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Car;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Make;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Model;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.CarRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.MakeRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.ModelRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.CarService;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CarServiceImpl implements CarService {

    private final CarRepository carRepository;
    private final MakeRepository makeRepository;
    private final ModelRepository modelRepository;

    @Override
    public List<CarDto> getAll() {
        return carRepository.findAll()
                .stream()
                .map(this::toCarDto)
                .toList();
    }

    @Override
    public CarDto get(int id) {
        Car car = carRepository.findById(id).get();
        return toCarDto(car);
    }

    @Override
    public CarDto toCarDto(Car car) {
        Model model = modelRepository.findById(car.getModelId()).get();
        Make make = makeRepository.findById(model.getMakeId()).get();
        return new CarDto(
                car.getId(),
                make.getMake(),
                model.getModel(),
                car.getBody(),
                car.getTransmission(),
                car.getEngine(),
                car.getDrive(),
                car.getEngineVolume(),
                car.getYear(),
                car.getHorsepower(),
                car.isLeftWheel()
        );
    }

    @Override
    public int saveIfNotExists(Car car) throws SaveException {
        Integer existingId = carRepository.checkIfExists(car);
        if (existingId == null) {
            try {
                carRepository.save(car);
            } catch (Exception e) {
                throw new SaveException("Couldn't save car.");
            }
            return car.getId();
        } else {
            return existingId;
        }
    }
}
