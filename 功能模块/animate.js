/*
    修改时间：2016、12、09
    编写人：黄伟梁

    动画函数
    参数：obj-------要执行动画的对象
          json------传入需要改变的参数
          fn--------回调函数


    使用求例：animate(liArr[j],{"width":240,"height":100},function(){
            console.log("111");
    });

 */

function animate(obj,json,fn) {
    clearInterval(obj.timer);
    obj.timer = setInterval(function() {
        var flag = true;
        for(var attr in json){
            var current = 0;
            if(attr == "opacity")
            {
                current = parseInt(getStyle(obj,attr)*100) || 100;
            }
            else
            {
                current = parseInt(getStyle(obj,attr)) || 0;
            }

            var step = ( json[attr] - current) / 10;
            step = step > 0 ? Math.ceil(step) : Math.floor(step);

            if(attr == "opacity")
            {
                if("opacity" in obj.style)
                {

                    obj.style.opacity = (current + step) /100;
                }
                else
                {
                    obj.style.filter = "alpha(opacity = "+(current + step)+")";
                    console.log(current);
                }
            }
            else if(attr == "zIndex")
            {
                obj.style.zIndex = json[attr];
            }
            else
            {
                obj.style[attr] = current  + step + "px" ;
            }

            if(current != json[attr])
            {
                flag =  false;
            }
        }
        if(flag)
        {
            clearInterval(obj.timer);

            if(fn)
            {
                fn();
            }
        }
    },10)
}


function getStyle(obj,attr) {
    if(obj.currentStyle)
    {
        return obj.currentStyle[attr];
    }
    else
    {
        return window.getComputedStyle(obj,null)[attr];  // w3c 浏览器
    }
}