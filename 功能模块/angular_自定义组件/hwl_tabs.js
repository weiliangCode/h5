//创建模型
var hwlModule = angular.module("hwlModule",[]);

//自定义指令（方式一）
hwlModule.directive("hwlTabs",function(){
	//返回指令的配置项
	return{
		restrict:"E",	//指令的形式 	E:元素， A：属性， C:class名字，M：注释
		templateUrl:"hwl_tabs.html",
		
		replace:false,			//是否替换包含的标签
		
		//设置隔绝的作用域,只会找自身作用域上的变量和方法，如果没有定义就不能使用
		scope: {
			tabsWords: '@', //接收普通的字符串
			tabsTitle: '=', //接收变量进行解析
			tabClick: '&', //接收函数，进行解析
			onChange: '&',
			selectTab: '='
			//在scope中未定义过的属性，是不能接收到的
		},
		controller: ['$scope', function($scope){
			console.log($scope.tabsTitle)
			
//			$scope.selectTab = 0;
			$scope.tabChange = function(index){
				
				$scope.selectTab = index;
				$scope.onChange({changeIndex: index});
			}
		}]
	}
})


//自定义指令（方式二）
hwlModule.directive('hwlTesta', function(){
	return {
		restrict: 'EACM',
		template: '<p>test</p>',
		replace: true			//是否替换包含的标签
	}
})

//自定义指令（方式三）
hwlModule.directive('hwlTestb', function(){
	//返回指令的配置项
	return {
		restrict: 'E',
		template: '<div >hello<div ng-transclude></div></div>',
		//是否替换包含的标签
		replace: false,
		
		transclude: true	//1.接收指令标签内部的值
							//2.给这个标签的 模板内容添加上ng-transclude指令，哪一
							//个标签有这个指令那么这个指令内部的内容给了这个标签

	}
})

//自定义指令（方式四）
hwlModule.directive('hwlTestc', function(){
	return {
		restrict: 'EACM',
		template: '<p ng-click="tabAction()">test {{name}} {{name1}}</p>',
		replace: true,			
				
		//设置独立的作用域,首先找自身作用域上的变量和方法，如果没找到就从父级中找
		scope: true,
		controller: ['$scope', function($scope){
			$scope.tabAction = function(){
				alert(2);
			}
			$scope.name = 'lisi';
		}]
		
	}
})
