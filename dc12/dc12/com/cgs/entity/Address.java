
package com.cgs.entity;

import java.util.Set;

public class Address {

    private String fullAddress;
    private Set<Customer> people;
    private String postCode;

    public void setFullAddress(String fullAddress) {
        this.fullAddress = fullAddress;
    }

    public String getFullAddress() {
        return fullAddress;
    }

    public void setPeople(Set<Customer> people) {
        this.people = people;
    }

    public Set<Customer> getPeople() {
        return people;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    public String getPostCode() {
        return postCode;
    }

}
