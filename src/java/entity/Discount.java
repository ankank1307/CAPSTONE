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
public class Discount {
    private String code;
    private int voucher_id;
    private int percent;
    private int quantity;
    private String end_date;
    private int status;
    private String description;

    public Discount(int voucher_id,String code, int percent, int quantity, String end_date, int status, String description) {
        this.voucher_id = voucher_id;
        this.code = code;
        this.percent = percent;
        this.quantity = quantity;
        this.end_date = end_date;
        this.status = status;
        this.description = description;
    }

    public Discount(String code, int percent, int quantity, String end_date, int status, String description) {
        this.code = code;
        this.percent = percent;
        this.quantity = quantity;
        this.end_date = end_date;
        this.status = status;
        this.description = description;
    }
    

    public int getVoucher_id() {
        return voucher_id;
    }

    public void setVoucher_id(int voucher_id) {
        this.voucher_id = voucher_id;
    }

    
    
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getPercent() {
        return percent;
    }

    public void setPercent(int percent) {
        this.percent = percent;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getEndDate() {
        return end_date;
    }

    public void setEndDate(String endDate) {
        this.end_date = endDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    

    
    
}

