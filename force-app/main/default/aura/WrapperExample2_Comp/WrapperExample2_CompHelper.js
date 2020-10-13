({
	industryDetails : function(cmp,event,helper) {
		var action = component.get("c.getIndustry");
        var inputIndustry = component.find("InputAccountIndustry");
        var opts = [];
        action.setCallback(this, function(a) {
            opts.push({
                class: "optionClass",
                label: "--- None ---",
                value: ""
            });
            for(var i=0;i< a.getReturnValue().length;i++){
                opts.push({"class": "optionClass",
                           label: a.getReturnValue()[i],
                           value: a.getReturnValue()[i]});
            }
            inputIndustry.set("v.options", opts);
            });
        $A.enqueueAction(action); 
    }
})