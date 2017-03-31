/*
    黄伟梁
    20161214
    调用格式：
 ajax({
    type:"get",
    url: "http://localhost:8080/ajax/checkname",
    param: {regname:"lisi", pwd:"123456"},
    async: true,
    success: function(data){
    },
    error: function(status, statusText){
    }
});
 */


//封装函数ajax
function ajax(obj){

    //1, 创建xhr对象
    var xhr = createXHR();

    //2, open()
    obj.param = getParamStr(obj.param);
    //console.log(obj.param);
    var reg= /^get$/i;
    if (reg.test(obj.type)){
        obj.url += obj.param.length>0 ? ("?"+obj.param) : "";
    }
    //console.log(obj.url);
    xhr.open(obj.type, obj.url, obj.async);

    //3, send()
    if (reg.test(obj.type)){
        xhr.send(null);
    }
    else {
        xhr.setRequestHeader("Content-Type", "applicationi/x-www-form-urlencoded");
        xhr.send(obj.param);
    }

    //4, 接收服务器的数据
    if (obj.async) { //异步
        xhr.onreadystatechange = function(){
            if (xhr.readyState == 4){
                callBack();
            }
        }
    }
    else { //同步
        callBack();
    }

    function callBack(){
        if (xhr.status == 200){     //成功
            if(obj.success)
            {
                //回调
                obj.success(xhr.responseText);
            }
        }
        else {  //失败
            if(obj.error)
            {
                obj.error(xhr.status, xhr.statusText);
            }
        }
    }
}

//把参数对象转换成字符串
function getParamStr(paramObj){
    var arr = [];
    for (var i in paramObj){
        var str = i + "=" + paramObj[i];
        arr.push(str);
    }
    return arr.join("&");
}

//封装函数创建xhr对象
function createXHR(){
    if (window.XMLHttpRequest) { //IE7+,谷歌, 火狐..
        return new XMLHttpRequest();
    }
    return new ActiveXObject("Microsoft.XMLHTTP"); //IE6
}