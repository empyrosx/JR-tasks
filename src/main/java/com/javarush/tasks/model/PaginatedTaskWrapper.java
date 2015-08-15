package com.javarush.tasks.model;

import java.util.List;
import org.springframework.data.domain.Page;

public class PaginatedTaskWrapper<T> {

    private final long pagesCount;
    private final List<T> data;

    public PaginatedTaskWrapper(Page<T> taskPage) {
        this.pagesCount = taskPage.getTotalElements();
        this.data = taskPage.getContent();
    }

    public long getPagesCount() {
        return pagesCount;
    }

    public List<T> getData() {
        return data;
    }
}