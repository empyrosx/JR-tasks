<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="JR_tasks">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <style type="text/css">
            ul>li, a{cursor: pointer;}

        </style>
        <title>JR-tasks for real project on JavaRush</title>
        <script src="js/angular.min.js"></script>
        <script src="js/ui-bootstrap-tpls-0.10.0.min.js"></script>
        <script src="js/app.js"></script>         
    </head>
    <body>
        <div ng-controller="JR_tasks_controller">
            <div class="container">
                <br/>

                <div class="row">
                    <div class="col-md-2">Задач на странице:
                        <select ng-model="pageSize" class="form-control" ng-change="applyFilter()">
                            <option>5</option>
                            <option>10</option>
                            <option>20</option>
                            <option>50</option>
                            <option>100</option>
                        </select>
                    </div>
                    <div class="col-md-10">    
                        <div pagination="" page="pageIndex" on-select-page="setPage(page)" boundary-links="true" total-items="totalItems" items-per-page="pageSize" class="pagination-small" first-text="В начало" last-text="В конец" previous-text="&laquo;" next-text="&raquo;"></div>
                    </div>

                    <div class="col-md-2">    
                        <button type="button" class="btn btn-primary" ng-hide="toggle" ng-click="toggle = !toggle">Добавить задание</button>
                    </div>
                </div>
                <br/>

                <!-- Все задачи-->
                <div class="container" ng-hide="toggle">
                    <div class="row">
                        <div class="col-md-12" >
                            <table class="table table-striped table-bordered">
                                <thead>
                                <th style="width:20%;">Наименование задачи&nbsp;</th>
                                <th style="width:20%;">Описание задачи&nbsp;</th>
                                <th style="width:10%;">Приоритет&nbsp;</th>
                                <th style="width:10%;">Статус&nbsp;</th>
                                <th style="width:10%;"> </th>
                                <th style="width:10%;"> </th>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <input type="text" ng-model="nameFilter" ng-keydown="onKeyDown($event)" class="form-control" />
                                        </td>
                                        <td>
                                            <input type="text" ng-model="descriptionFilter" ng-keydown="onKeyDown($event)" class="form-control" />
                                        </td>
                                        <td>
                                            <select ng-model="priorityFilter" ng-options="priority as priority for priority in priorities" class="form-control" ng-change="applyFilter()">
                                                <option></option>
                                            </select>
                                        </td>
                                        <td>
                                            <select ng-model="statusFilter" ng-options="status as status for status in statuses" class="form-control" ng-change="applyFilter()">
                                                <option></option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr ng-repeat="task in tasks">
                                        <td>{{task.name}}</td>
                                        <td>{{task.description}}</td>
                                        <td align="center">{{task.priority}}</td>
                                        <td align="center">{{task.status}}</td>
                                        <td align="center"><a ng-click="editTask(task)" class="btn btn-small btn-primary">изменить</a></td>
                                        <td align="center"><a ng-click="deleteTask(task.id)" class="btn btn-small btn-danger">удалить</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-12" ng-show="totalItems == 0">
                            <div class="col-md-12">
                                <h4>Нет заданий</h4>
                            </div>
                        </div>
                    </div>
                </div>

                <br/>

                <div class="container" ng-hide="!toggle">
                    <div class="col-md-8" >
                        <h4>Создание нового задания:</h4>
                    </div>
                    <div class="col-md-8" >
                        <table class="table">
                                <thead>
                                <th style="width:20%;"></th>
                                <th style="width:80%;"></th>
                                </thead>
                            <tr>
                                <td>Наименование:</td>
                                <td><input type="text" ng-model="name" class="form-control" /></td>
                            </tr>
                            <tr>
                                <td>Описание:</td>
                                <td><textarea ng-model="description" class="form-control" ></textarea></td>
                            </tr>
                            <tr>
                                <td>Приоритет:</td>
                                <td>
                                    <select ng-model="priority" ng-options="priority as priority for priority in priorities" class="form-control" >
                                        <option value="">-- Выбрать --</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Статус:</td>
                                <td>
                                    <select ng-model="status" ng-options="status as status for status in statuses" class="form-control" >
                                        <option value="">-- Выбрать --</option>                     
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td align="right">
                                    <font color="red"><label ng-hide="!hasAddTaskErrors">Ошибка: необходимо заполнить все поля</label></font>
                                    <button type="button" class="btn btn-primary" ng-click="saveTask()">Сохранить</button>
                                    <button type="button" class="btn btn-primary" ng-click="toggle = !toggle; hasAddTaskErrors = false">Отменить</button>
                                </td>
                            </tr>                       

                        </table>                                
                    </div>
                </div>

            </div>
    </body>
</html>