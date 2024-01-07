/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author phuon
 */
/**
 *
 * @author BLC
 */
public class Book {

    private int book_id;
    private String title;
    private int author_id;
    private int genre_id;
    private int price;
    private int quantity;
    private int yor;
    private String description;
    private int book_status;
    private String picture;
    private String author_name;
    private String genre;

    public Book(int book_id, String title, int author_id, int genre_id, int price, int quantity, int yor, String description, int book_status) {
        this.book_id = book_id;
        this.title = title;
        this.author_id = author_id;
        this.genre_id = genre_id;
        this.price = price;
        this.quantity = quantity;
        this.yor = yor;
        this.description = description;
        this.book_status = book_status;
    }

    public Book(String title, int author_id, int genre_id, int price, int quantity, int yor, String description, int book_status) {
        this.title = title;
        this.author_id = author_id;
        this.genre_id = genre_id;
        this.price = price;
        this.quantity = quantity;
        this.yor = yor;
        this.description = description;
        this.book_status = book_status;
    }

    public Book(int book_id, String title, int price, int quantity, int yor, String description, int book_status, String author_name, String genre, String picture) {
        this.book_id = book_id;
        this.title = title;
        this.price = price;
        this.quantity = quantity;
        this.yor = yor;
        this.description = description;
        this.book_status = book_status;
        this.author_name = author_name;
        this.genre = genre;
        this.picture = picture;
    }

    public Book(int book_id, int quantity) {
        this.book_id = book_id;
        this.quantity = quantity;
    }
    
    
    

    public Book(int book_id, String title, int author_id, int genre_id, int price, int quantity, int yor, String description, int book_status, String picture) {
        this.book_id = book_id;
        this.title = title;
        this.author_id = author_id;
        this.genre_id = genre_id;
        this.price = price;
        this.quantity = quantity;
        this.yor = yor;
        this.description = description;
        this.book_status = book_status;
        this.picture = picture;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }

    public int getGenre_id() {
        return genre_id;
    }

    public void setGenre_id(int genre_id) {
        this.genre_id = genre_id;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getYor() {
        return yor;
    }

    public void setYor(int yor) {
        this.yor = yor;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getBook_status() {
        return book_status;
    }

    public void setBook_status(int book_status) {
        this.book_status = book_status;
    }

    public String getAuthor_name() {
        return author_name;
    }

    public void setAuthor_name(String author_name) {
        this.author_name = author_name;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }
    

}
