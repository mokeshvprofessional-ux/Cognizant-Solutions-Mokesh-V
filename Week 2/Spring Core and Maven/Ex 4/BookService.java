package com.library.service;

import com.library.repository.BookRepository;

public class BookService {

    private BookRepository repository = new BookRepository();

    public void displayBook() {
        System.out.println("Book Name: " + repository.getBook());
    }
}