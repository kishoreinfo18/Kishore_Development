({
	fireChangeEvent : function(component,fieldName) {
        var changeEvent = component.getEvent("inputChanged");
        changeEvent.setParam("fieldName",fieldName)
        changeEvent.fire();
	}
})