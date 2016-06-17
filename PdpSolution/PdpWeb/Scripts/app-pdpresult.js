var app = angular.module('appPdp', [
	'ui.grid',
	'ui.grid.pagination',
	'ui.grid.selection',
	'ui.grid.resizeColumns',
	'ui.grid.exporter'
]);

app.controller('MainCtrl', function ($scope, $http, uiGridConstants) {
	var paginationOptions = {
		sort: null
	};

	$scope.gridResul = {
		enableHorizontalScrollbar: 0,
		enableFiltering: true,
		enableGridMenu: true,
		exporterMenuCsv: true,
		useExternalPagination: true,
		useExternalSorting: true,
		exporterAllDataFn: function () {
			return getPage(1, $scope.gridResul.totalItems, paginationOptions.sort)
			.then(function () {
				$scope.gridResul.useExternalPagination = false;
				$scope.gridResul.useExternalSorting = false;
				getPage = null;
			});
		},
		onRegisterApi: function (gridApi) {
			$scope.gridApi = gridApi;
			$scope.gridApi.core.on.sortChanged($scope, function (grid, sortColumns) {
				if (getPage) {
					if (sortColumns.length > 0) {
						paginationOptions.sort = sortColumns[0].sort.direction;
					} else {
						paginationOptions.sort = null;
					}
					getPage(grid.options.paginationCurrentPage, grid.options.paginationPageSize, paginationOptions.sort)
				}
			});
			gridApi.pagination.on.paginationChanged($scope, function (newPage, pageSize) {
				if (getPage) {
					getPage(newPage, pageSize, paginationOptions.sort);
				}
			});
		}
	};

	$scope.LoadGridData = function () {
		var sUrl = "/PdpApi/api/ResultsData?MaxRecordCount=1000";
		$http.get(sUrl)
		.success(function (data) {
			$scope.gridResul.data = data;
		}).error(function () {
			alert('err');
		});
	};

	//$scope.LoadGridData();

	var getPage = function (curPage, pageSize, sort) {
		var url = "/PdpApi/api/ResultsData?MaxRecordCount=10000";
		switch (sort) {
			case uiGridConstants.ASC:
				url += '&sort=ASC';
				break;
			case uiGridConstants.DESC:
				url += '&sort=DESC';
				break;
			default:
				url += '&sort=';
				break;
		}

		var _scope = $scope;
		return $http.get(url)
		.success(function (data) {
			var firstRow = (curPage - 1) * pageSize;
			$scope.gridResul.totalItems = 10000;
			$scope.gridResul.data = data.slice(firstRow, firstRow + pageSize)
		});
	};

	getPage(1, $scope.gridResul.paginationPageSize);
});
