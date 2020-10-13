({
	onChildAttributeChange : function(component, event, helper) {
       alert('old value is:'+event.getParam("oldValue"));
        alert('New Value is:'+event.getParam("value"));
	}
})