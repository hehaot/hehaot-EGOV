
//定义表单项类型
//类名：FormItem，属性包括两个：label，id
FormItem=function (label,id){
    this.label=label;
    this.id=id;
}

//工具类
EGOV=function(){
    //验证非空(运行阶段此方法只能接收数组，并且数组中每一个元素都是FormItenm类型)
    this.isNotEmpty=function (formItemArr){
        for (var i=0;i<formItemArr.length;i++){
            var formItem = formItemArr[i];
            var id=formItem.id;
            var label=formItem.label;
            var domObj =document.getElementById(id);
            if(domObj.value==""){
                alert(label+"不能为空，请重新填写");
                domObj.focus();
                return false;
            }
        }
        return true;
    }
    //验证一致，（程序运行的时候formIteml和formItem2都是FormItem类型的对象）
    this.isSame=function (formItem1,formItem2){
        var id1 =formItem1.id;
        var label1=formItem1.label;
        var domObj1=document.getElementById(id1);

        var id2=formItem2.id;
        var label2=formItem2.label;
        var domObj2=document.getElementById(id2);

        if (domObj1.value != domObj2.value){
            alert(label1+"和"+label2+"不一致，请重新填写");
            domObj1.value="";
            domObj2.value="";
            domObj1.focus();
            return false;
        }
        return true;
    }
}
 var $=new EGOV();