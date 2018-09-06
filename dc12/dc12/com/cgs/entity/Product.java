
package com.cgs.entity;

import java.math.BigDecimal;

public abstract class Product {

    private String name;
    private String id;
    private BigDecimal listPrice;

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setListPrice(BigDecimal listPrice) {
        this.listPrice = listPrice;
    }

    public BigDecimal getListPrice() {
        return listPrice;
    }

}
