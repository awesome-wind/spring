package com.wz.demoPro.repository;

import com.wz.demoPro.entity.User;
import com.wz.demoPro.entity.Work;
import org.hibernate.annotations.SQLDelete;
import org.jboss.logging.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface WorkRepository extends JpaRepository<Work,Integer>{


}
