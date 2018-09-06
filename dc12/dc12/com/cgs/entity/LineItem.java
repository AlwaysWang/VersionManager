
package com.cgs.entity;


public class LineItem {

    private java.math.BigDecimal amount;
    private java.math.BigDecimal price;
    private Product product;

    public void setAmount(java.math.BigDecimal amount) {
        this.amount = amount;
    }

    public java.math.BigDecimal getAmount() {
        return amount;
    }

    public void setPrice(java.math.BigDecimal price) {
        this.price = price;
    }

    public java.math.BigDecimal getPrice() {
        return price;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Product getProduct() {
        return product;
    }

}
