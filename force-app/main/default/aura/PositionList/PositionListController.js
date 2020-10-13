({
	doInit : function(component, event) {
        var action =component.get("c.findAll");
        action.setcallBack(this,function(a)
        {
            Component.set("v.postion",a.getRetrunValues());               
        });
      $a.enqueAction(action);  
	}
})