//缓冲运动
function animate(obj,attr,target,fn){
	//清除已有定时器
	clearInterval(obj.timer);
	
	//开启运动定时器
	obj.timer = setInterval(function(){
		//1.
		var current=0;
		var reg = /^opacity$/i;
		if(reg.test(attr))
		{
			current =Math.round(getStyle(obj,attr)*100);
	
		}
		else{
			current = parseInt(getStyle(obj,attr)) || 0;
			
		}
		
		//2
		var speen = (target-current)/10;
		speen = speen>0 ?Math.ceil(speen) :Math.floor(speen);
		
		//3.
		if(target == current)
		{
			clearInterval(obj.timer);
			if(fn)
			{
				fn();
			}
			return;
		}
		
		//4.
		if(reg.test(attr))
		{
			obj.style[attr] = (current + speen)/100;
			obj.style["filter"] = "alpha(opacity:" + (current + speen) +")";
		}else{
			obj.style[attr] = current + speen + "px";
		}
		
	},30)
}


function getStyle(obj,attr) {
    if(obj.currentStyle)
    {
        return obj.currentStyle[attr];
    }
  	 return window.getComputedStyle(obj,null)[attr];  // w3c 浏览器
    
}