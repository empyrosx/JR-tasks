package com.javarush.tasks.controller;

import com.javarush.tasks.repository.TaskRepository;
import com.javarush.tasks.model.PaginatedTaskWrapper;
import com.javarush.tasks.model.Task;
import com.javarush.tasks.specification.TaskSpecification;
import java.text.ParseException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.util.StopWatch.TaskInfo;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
public class TaskManagerController {

    @Autowired
    TaskRepository taskRepository;

    @RequestMapping(value = "/tasks", method = RequestMethod.GET, headers = "Accept=application/json")
    public PaginatedTaskWrapper<Task> getAllTasks(@RequestParam("page") int page, @RequestParam("size") int size, @ModelAttribute Task taskInfo) {
        Specification<TaskInfo> spec = new TaskSpecification(taskInfo);
        Page<Task> taskPage = taskRepository.findAll(spec, new PageRequest(page, size));
        return new PaginatedTaskWrapper<>(taskPage);
    }

    @RequestMapping(value = "/tasks/append", method = RequestMethod.POST, headers = "Accept=application/json")
    public Task appendTask(@RequestBody Task task) {
        return taskRepository.save(task);
    }

    @RequestMapping(value = "/tasks/update", method = RequestMethod.POST, headers = "Accept=application/json")
    public void updateTask(@RequestBody Task taskInfo) throws ParseException {
        Task task = taskRepository.findOne(taskInfo.getId());
        task.setName(taskInfo.getName());
        task.setDescription(taskInfo.getDescription());
        task.setPriority(taskInfo.getPriority());
        task.setStatus(taskInfo.getStatus());
        taskRepository.saveAndFlush(task);
    }

    @RequestMapping(value = "/tasks/delete", method = RequestMethod.POST, headers = "Accept=application/json")
    public void deleteTask(@RequestBody Long taskId) throws ParseException {
        taskRepository.delete(taskId);
    }
}