package com.javarush.tasks.repository;

import com.javarush.tasks.model.Task;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long>, JpaSpecificationExecutor {
}
