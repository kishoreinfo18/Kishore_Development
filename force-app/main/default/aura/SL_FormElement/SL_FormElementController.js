({
	doInit : function(component, event, helper) {
        if(component.get("v.required")) {
			$A.util.addClass(component.find("SL_FormElement"), "slds-is-required");
        }
	},
	addError : function(component, event, helper) {
        var params = event.getParam("arguments");
        if (params) {
            var errorMessage = params.message;
            var errorComponent = [["c:SL_FormElementError", { message : errorMessage }]];
            $A.createComponents(errorComponent,
                function(newErrorComponents, status, statusMessagesList){
                    component.set("v.error", newErrorComponents);
                    component.set('v.hasError',true);

                    //component.find("SL_FormElement").set('v.hasError',true);
                    //$A.util.addClass(component.find("SL_FormElement"), "slds-has-error");
                });
        }
    },
    
    addErrors : function(component, event, helper) {
        var params = event.getParam("arguments");
        if (params) {
            var messages = params.messages;
            var errorComponents = [];
            messages.forEach(function(message){
                errorComponents.push(["c.SL_FormElementError",{ "message" : message }]);
            });
            $A.createComponents(
                errorComponents, function(newErrorComponents, status, statusMessagesList){
                    component.set("v.error", newErrorComponents);

                    $A.util.addClass(component.find("SL_FormElement"), "slds-has-error");
                });
        }
    },
    
    clearError : function(component, event, helper) {
        component.set("v.error", []);
        component.set("v.formClass","");
        component.set('v.hasError',false);

        //$A.util.removeClass(component.find("SL_FormElement"), "slds-has-error");
    },

    handleChangeEvent : function(component, event, helper) {    	
    	component.set("v.value",event.target.value);
    	if(component.get("v.required"))
    	{
        	helper.fireChangeEvent(component,component.get("v.id"));
    	}
	}
})