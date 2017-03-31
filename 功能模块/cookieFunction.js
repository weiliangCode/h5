/*
   20161207 --黄伟梁
 */

//存入cookie
function setcookie(name,value,expires){
    var coStr = encodeURIComponent(name) +"=" +encodeURIComponent(value);

    if(expires instanceof Date)
    {
        coStr += ";" + "expires =" +expires +";";
    }

    document.cookie = coStr;
}

//查: 获取cookie
function getcookie(name){

    var cookieStr = document.cookie;
    var arr = cookieStr.split("; ");
    for (var i=0; i<arr.length; i++){

        arrTemp =arr[i].split("=");
        var nameTemp = decodeURIComponent(arrTemp[0]);
        if(nameTemp == name)
        {
            return decodeURIComponent(arrTemp[1]);
        }
    }
    return "";
}


//删除cookie
function delecookie(name){
    var coStr = encodeURIComponent(name);
    coStr += "=; expires =" +new Date();
    document.cookie = coStr;
}
