package ru.kpfu.itis.gr201.ponomarev.springcars.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.SaveException;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Make;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Model;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.MakeRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.ModelRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.ModelService;

@Service
@RequiredArgsConstructor
public class ModelServiceImpl implements ModelService {

    private final MakeRepository makeRepository;
    private final ModelRepository modelRepository;

    @Override
    public int saveIfNotExists(String make, String model) throws SaveException {
        Make existingMake = makeRepository.findByMake(make);
        if (existingMake == null) {
            existingMake = makeRepository.save(new Make(make));
        }
        Model existingModel = modelRepository.findByMakeIdAndModel(existingMake.getId(), model);
        if (existingModel == null) {
            existingModel = modelRepository.save(new Model(existingMake.getId(), model));
        }
        return existingModel.getId();
    }
}
