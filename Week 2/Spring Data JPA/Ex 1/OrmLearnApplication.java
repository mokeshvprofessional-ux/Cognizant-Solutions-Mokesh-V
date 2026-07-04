package com.cognizant.springlearn;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.cognizant.springlearn.model.Country;
import com.cognizant.springlearn.repository.CountryRepository;

@SpringBootApplication
public class OrmLearnApplication implements CommandLineRunner {

    @Autowired
    private CountryRepository repository;

    public static void main(String[] args) {
        SpringApplication.run(OrmLearnApplication.class, args);
    }

    @Override
    public void run(String... args) {

        repository.save(new Country("IN", "India"));
        repository.save(new Country("US", "United States"));
        repository.save(new Country("JP", "Japan"));

        System.out.println(repository.findAll());
    }
}