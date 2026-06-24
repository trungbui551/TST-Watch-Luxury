package com.tstwatchluxury.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "vip_appointments")
public class VipAppointment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "full_name", nullable = false)
    private String fullName;

    @Column(name = "phone_number", nullable = false)
    private String phoneNumber;

    @Column(name = "email")
    private String email;

    @Column(name = "service_type")
    private String serviceType;

    @Column(name = "boutique")
    private String boutique;

    @Column(name = "appointment_time", nullable = false)
    private LocalDateTime appointmentTime;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;

    @Column(name = "status")
    private String status = "Chờ xác nhận"; // Default status: "Chờ xác nhận", "Đã xác nhận", "Đã hủy"

    public VipAppointment() {
    }

    public VipAppointment(String fullName, String phoneNumber, String email, String serviceType, String boutique, LocalDateTime appointmentTime, String notes) {
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.serviceType = serviceType;
        this.boutique = boutique;
        this.appointmentTime = appointmentTime;
        this.notes = notes;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    public String getBoutique() {
        return boutique;
    }

    public void setBoutique(String boutique) {
        this.boutique = boutique;
    }

    public LocalDateTime getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(LocalDateTime appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFormattedAppointmentTime() {
        if (appointmentTime == null) return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return appointmentTime.format(formatter);
    }
}
