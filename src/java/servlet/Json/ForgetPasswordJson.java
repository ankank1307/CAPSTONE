/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet.Json;

import com.google.gson.Gson;
import entity.OTPCode;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 *
 * @author phuon
 */
public class ForgetPasswordJson extends HttpServlet {
static HashMap<Integer, List<OTPCode>> map = new HashMap<>();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgetPasswordJson</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgetPasswordJson at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<OTPCode> listValue;
        HttpSession mySession = request.getSession();
        Integer value = (Integer) mySession.getAttribute("otp");
        if (value != null) {
            OTPCode otpCode = new OTPCode(value);
            listValue = new ArrayList<>();
            listValue.add(0, otpCode);
            for (int i = 0; i < listValue.size(); i++) {
                if (listValue.get(i) != null) {
                    Gson gson = new Gson();
                    String json = gson.toJson(listValue.get(i));
                    System.out.println("Received value: " + listValue.get(i).getValue());
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(json);
                    map.put(i, listValue);
                }
            }
        }else{
                listValue = map.get(0);
                
                for (int i = 0; i <listValue.size(); i++) {
                 if (listValue.get(i) != null) {
                    Gson gson = new Gson();
                    String json = gson.toJson(listValue.get(i));
                    System.out.println("Received value: " + listValue.get(i).getValue());
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(json);
                }
            }
            }
        }
    

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        reader.close();
        JSONObject requestDataJson = new JSONObject(sb.toString());
        String email = requestDataJson.getString("email");

        int otpvalue = 0;
        HttpSession mySession = request.getSession();

        if (email != null || !email.equals("")) {
            // sending otp
            Random rand = new Random();
            otpvalue = 100000 + rand.nextInt(900000);

            String to = email;// change accordingly
            // Get the session object
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.starttls.enable", "true");
            Session session = Session.getInstance(props, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("phuonganhnguyenthi728@gmail.com", "jdttyugzmimzagwy");// Put your email
                    // id and
                    // password here
                }
            });
            // compose message
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(email));// change accordingly
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject("Confirm your account");
                message.setText("Your validate code is: " + otpvalue);
                // send message
                Transport.send(message);
                System.out.println("message sent successfully");
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }

            request.setAttribute("message", "OTP is sent to your email id");
            //request.setAttribute("connection", con);
            mySession.setAttribute("otp", otpvalue);
            mySession.setAttribute("email", email);
            //request.setAttribute("status", "success");
            System.out.println("Sent value: " + otpvalue);
//            RequestDispatcher dispatcher = request.getRequestDispatcher("SentOTPServlet");
//            dispatcher.forward(request, response);
            doGet(request, response);

        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
