({
	doinit : function(component, event, helper) {
        var acntId = component.get("v.AccntNumber");
        var acntName=component.get("v.AcntName");
        var action = component.get("c.getAccounts");
        action.setParams({"accntId" : acntId,AcntName:acntName});
        action.setCallback(this, function(response){
            component.set("v.account",response.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})