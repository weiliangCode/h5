onload = function(){
	shufflingFigure();
}

//轮播图函数	
function shufflingFigure(){
	//===================================================
	//0.定义全局变量
	var imgWidth = 0;	//图片的宽度
	var num = 0;		//当前显示的第几张图
	var time = null;	//定时播放的定时器	

	var box = document.getElementById("box");		//大盒子
	var lis = document.getElementById("lis");		//存放图片ul
	var lis1 = document.getElementById("lis1");		//存放按钮ul
	var lis2 = document.getElementById("lis2");		//存放上/下按钮ul
	var liArr = lis.getElementsByTagName("li");		//图片li
	var liIndexArr = lis1.getElementsByTagName("li");//按钮li
	var lis2 = document.getElementById("lis2");		 //上下按钮
	var btnArr = lis2.getElementsByTagName("li");	 //下/下按钮数组
	
	//===================================================
	//1.加载数据
	ajax({
		type:"get",  	
		url: "jsonData.json",
		param: "",
		async: true, 
		success: function(data){
			imgInile(data);
		},
		error: function(status, statusText){	
			console.log("error");
		}
	});
	//===================================================
	//2.创建图片节点和按钮节点
	function imgInile(data){
		var dataArr = JSON.parse(data);
		for(var i=0;i<dataArr.length;i++)
		{
			//创建大图节点
			//<li><img src="images/b2.jpg"/></li>
			var li1 = document.createElement("li");
			var img = document.createElement("img");
			img.src = dataArr[i].img;
			li1.appendChild(img);
			lis.appendChild(li1);
			
			//创建按键节点
			//<li class = "select">1</li>
			var li2 = document.createElement("li");
			li2.innerHTML = i+1;
			if(i==0)
			{
				li2.className = "select";
			}
			lis1.appendChild(li2);
		}
		startAnimation();
	}
	//===================================================
	//3.初始化开始动画
	function startAnimation(){
		imgWidth = liArr[0].offsetWidth;
		lis.style.width = imgWidth *(liArr.length+1)
		
		//把第一张图拷贝到第后
		lis.appendChild(liArr[0].cloneNode(true));
	
		//定时滚动
		time = setInterval(function(){
			num++;
			move();
		},2000);

		//给按钮添加一个移入事件
		for(var i=0;i<liIndexArr.length;i++)
		{
			liIndexArr[i].onmouseenter = function(){
				num = this.innerHTML - 1;
				move();
			}
		}
	}
	//===================================================
	//4.移动
	function move(){
		if(num<0)
		{
			num = liIndexArr.length-1;
			lis.style.left = -(num+1) *imgWidth;
		}
		if(num>liIndexArr.length)
		{
			num = 1;
			lis.style.left = 0;
		}
		animate(lis,"left",-num*imgWidth);
		for(var j=0;j<liIndexArr.length;j++)
		{
			if(num==j)
			{
				liIndexArr[j].className = "select";
			}else{
				liIndexArr[j].className = "";
			}
		}
		if(num==liIndexArr.length)
		{
			liIndexArr[0].className = "select";
		}
	}
	//===================================================
	//5.事件监听
	//鼠标移入停止定时器
	box.onmouseenter = function(){
		clearInterval(time);
	}
	//鼠标移出重新开启定时器
	box.onmouseleave = function(){
		clearInterval(time);
		time = setInterval(function(){
			move();
			num++;
		},2000);
	}
	//-----------------------------------------------
	//上/下一张图
	//上一张
	btnArr[0].onclick = function(){
		num--;
		move();
	}
	//下一张
	btnArr[1].onclick = function(){
		num++;
		move();
	}
}