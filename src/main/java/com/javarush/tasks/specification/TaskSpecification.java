package com.javarush.tasks.specification;

import com.javarush.tasks.model.Task;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.util.StopWatch.TaskInfo;

public class TaskSpecification implements Specification<TaskInfo> {

    private final Task criteria;

    public TaskSpecification(Task taskInfo) {
        this.criteria = taskInfo;
    }

    @Override
    public Predicate toPredicate(Root<TaskInfo> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
        List<Predicate> result = new ArrayList();
        addPredicate(result, root, cb, "name", criteria.getName());
        addPredicate(result, root, cb, "description", criteria.getDescription());
        addPredicate(result, root, cb, "priority", criteria.getPriority());
        addPredicate(result, root, cb, "status", criteria.getStatus());
        return cb.and(result.toArray(new Predicate[result.size()]));
    }

    private void addPredicate(List<Predicate> result, Root<TaskInfo> root, CriteriaBuilder cb, String attrName, String attrValue) {
        if (attrValue != null) {
            Path attr = root.get(attrName);
            if (attrValue.contains("%")) {
                result.add(cb.like(attr, attrValue));
            } else {
                result.add(cb.equal(attr, attrValue));
            }
        }
    }
}
