({
    //Fetch the accounts from the Apex controller
    getAccounts: function(component) {
     	var action = component.get("c.getAccounts");
     	//Set up the callback
     	action.setCallback(this, function(actionResult) {
            component.set("v.accounts", actionResult.getReturnValue());
        	component.set("v.accountsLength", actionResult.getReturnValue().length); 
      	});	
        $A.enqueueAction(action);  
    }
})