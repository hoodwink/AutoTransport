var app = angular.module('appPdp', [
    'ui.grid',
    'ui.grid.resizeColumns',
    'ui.grid.exporter'
]);

app.controller('MainCtrl', function ($scope,$http) {

    $scope.LoadGridData = function () {

        $scope.gridResul = {
            enableHorizontalScrollbar: 0,
            enableFiltering: true,
            enableGridMenu: true,
            exporterMenuCsv: true
        };

        var sUrl = "/PdpApi/api/ResultsData?MaxRecordCount=1000";
        $http.get(sUrl)
        .success(function (data) {
        	$scope.gridResul.data = data;
        }).error(function () {
            alert('err');
        });
    };

    $scope.LoadGridData();
});
