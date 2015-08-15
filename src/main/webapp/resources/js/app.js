var app = angular.module('JR_tasks', ['ui.bootstrap']);

// контроллер приложения
app.controller('JR_tasks_controller', function ($scope, $http) {

    var urlBase = "http://localhost:8080/JR-tasks";
    $scope.tasks = [];
    $scope.pageIndex = 1;
    $scope.pageSize = 10;
    $scope.pageCount = 0;
    $scope.totalItems = 0;
    $scope.nameFilter = "";
    $scope.descriptionFilter = "";
    $scope.priorityFilter = "";
    $scope.statusFilter = "Действует";
    $scope.id = -1;
    $scope.name = "";
    $scope.description = "";
    $scope.priority = "";
    $scope.status = "";
    $scope.statuses = ['Действует', 'Завершено'];
    $scope.priorities = ['Срочный', 'Высокий', 'Нормальный', 'Низкий'];
    $scope.toggle = false;

    // получение одной страницы данных
    $scope.getPageData = function (page) {
        var params = {
            page: page - 1,
            size: $scope.pageSize
        };
        if ($scope.nameFilter) {
            params["name"] = $scope.nameFilter;
        }
        if ($scope.descriptionFilter) {
            params["description"] = $scope.descriptionFilter;
        }
        if ($scope.priorityFilter) {
            params["priority"] = $scope.priorityFilter;
        }
        if ($scope.statusFilter) {
            params["status"] = $scope.statusFilter;
        }
        $http({
            url: urlBase + '/tasks',
            method: 'GET',
            params: params
        }).success(function (result) {
            $scope.tasks = result.data;
            $scope.totalItems = result.pagesCount;
            $scope.pageCount = Math.ceil(result.pagesCount / $scope.pageSize);
            $scope.filteredItems = $scope.tasks.length;
        });
    };

    $scope.setPage = function (pageIndex) {
        $scope.pageIndex = pageIndex;
        $scope.getPageData(pageIndex);
    };


    $scope.onKeyDown = function ($event) {
        var key = window.event ? $event.keyCode : $event.which;
        if (key == 13) {
            $scope.applyFilter();
        }
    };

    $scope.applyFilter = function () {
        // пользователь надал enter
        $scope.setPage($scope.pageIndex);
    };

    // добавление задания
    $scope.saveTask = function saveTask() {
        if ($scope.name == "" || $scope.description == "" || $scope.priority == "" || $scope.status == "") {
            $scope.hasAddTaskErrors = true;
        }
        else {
            $scope.hasAddTaskErrors = false;
            var task = {};
            if ($scope.id > -1) {
                task["id"] = $scope.id;
            }
            task["name"] = $scope.name;
            task["description"] = $scope.description;
            task["priority"] = $scope.priority;
            task["status"] = $scope.status;

            $http.post($scope.id == -1 ? urlBase + '/tasks/append' : urlBase + '/tasks/update', task).
                    success(function (data) {
                        $scope.toggle = !$scope.toggle;
                        $scope.id = -1;
                        $scope.name = "";
                        $scope.description = "";
                        $scope.priority = "";
                        $scope.status = "";
                        $scope.setPage($scope.pageIndex);
                    });
        }
    };

    // изменение задания
    $scope.editTask = function updateTask(task) {
        $scope.id = task["id"];
        $scope.name = task["name"];
        $scope.description = task["description"];
        $scope.priority = task["priority"];
        $scope.status = task["status"];
        $scope.toggle = !$scope.toggle;
    };

    // удаление задания
    $scope.deleteTask = function deleteTask(id) {
        $http.post(urlBase + '/tasks/delete', id).
                success(function (data) {
                    $scope.id = -1;
                    $scope.setPage($scope.pageIndex);
                });
    };

    // запрашиваем данные первой страницы
    $scope.setPage(1);
});