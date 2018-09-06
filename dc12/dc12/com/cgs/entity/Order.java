
package com.cgs.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class Order {

    private BigDecimal discount;
    private String id;
    private Date commitTime;
    private List<LineItem> items;
    private String status;
    private Customer customer;

    public void setDiscount(BigDecimal discount) {
        this.discount = discount;
    }

    public BigDecimal getDiscount() {
        return discount;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setCommitTime(Date commitTime) {
        this.commitTime = commitTime;
    }

    public Date getCommitTime() {
        return commitTime;
    }

    public void setItems(List<LineItem> items) {
        this.items = items;
    }

    public List<LineItem> getItems() {
        return items;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Customer getCustomer() {
        return customer;
    }

}
