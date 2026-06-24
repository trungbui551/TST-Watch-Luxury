package com.tstwatchluxury.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.tstwatchluxury.domain.VipAppointment;
import java.util.List;

@Repository
public interface VipAppointmentRepository extends JpaRepository<VipAppointment, Long> {
    List<VipAppointment> findAllByOrderByAppointmentTimeDesc();
}
