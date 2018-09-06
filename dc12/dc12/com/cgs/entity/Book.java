
package com.cgs.entity;

import java.util.List;

public class Book
    extends Product
{

    private String isbn;
    private List authors;

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setAuthors(List authors) {
        this.authors = authors;
    }

    public List getAuthors() {
        return authors;
    }

}
