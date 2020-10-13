({
    doInit: function(component, event, helper) {
        var action = component.get("c.getIndustry");
        var inputIndustry = component.find("InputAccountIndustry");
        alert('input industry is '+inputIndustry);
        var opts=[];
        action.setCallback(this, function(a) {
            opts.push({
                class: "optionClass",
                label: "--- None ---",
                value: ""
            });
        alert('opt si input industry is '+opts);    
            for(var i=0;i< a.getReturnValue().length;i++){
                opts.push({"class": "optionClass", label: a.getReturnValue()[i], value: a.getReturnValue()[i]});
            }
            inputIndustry.set("v.options", opts);
             
        });
        $A.enqueueAction(action); 
    },
    onPicklistChange: function(component, event, helper) {
        //get the value of select option
        var selectedIndustry = component.find("InputAccountIndustry");
        alert(selectedIndustry.get("v.value"));
        var action1 = component.get("c.getAccDetails");
        alert('1...123');
        action1.setCallback(this, function(actionResult) {
            let state = actionResult.getState();
            alert('1...123+state'+state);
            component.set("v.accountList", actionResult.getReturnValue());
        });
        //$A.enqueueAction(selectedIndustry);
    }
})