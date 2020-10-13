({
	doinit : function(component, event, helper) {
        var action = component.get("c.getContactList");
        action.setCallback(this, function(response){
            component.set("v.contact",response.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})