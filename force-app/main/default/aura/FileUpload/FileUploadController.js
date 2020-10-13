({
    doSave: function(component, event, helper) {
        if (component.find("fileId").get("v.files").length > 0) {
            helper.uploadHelper(component, event);
        } else {
            alert('Please Select a Valid File');
        }
    },
 
    handleFilesChange: function(component, event, helper) {
       debugger;
        var fileName=[];
        var fileDetials = event.getSource().get("v.files");
        alert('filedetails are' + fileDetials);
        for(var i = 0;i<fileDetials.length;i++){
            fileName.push(fileDetials[i]['name']);
        }
        /*if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }*/
        component.set("v.fileName", fileName);
       // alert('file name are123 :' +component.get("v.fileName"));
    },
})