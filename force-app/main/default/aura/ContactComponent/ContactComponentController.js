({
	create : function(component, event, helper) {
        var Contact = component.get("v.contact");
		var action = component.get("c.createRecord");
         action.setParams({
            contact : Contact
        });
        $A.enqueueAction(action);
	}
})