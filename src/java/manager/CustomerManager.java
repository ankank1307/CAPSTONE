/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package manager;

import dao.CustomerDAO;
import entity.Customer;
import java.util.ArrayList;

/**
 *
 * @author phuon
 */
public class CustomerManager {
     private ArrayList<Customer> listCustomer;
    private CustomerDAO myCustomerDAO;
    

    public CustomerManager() {
        this.listCustomer = new ArrayList();
        myCustomerDAO=new CustomerDAO();
        
    }
    
    public  CustomerManager(ArrayList<Customer> listCustomer)
    {
        this.listCustomer= listCustomer;
        myCustomerDAO=new CustomerDAO();
    }
    
     public void addCustomer(Customer customer) {
        this.myCustomerDAO.insertCustomer(customer);
    }
}
