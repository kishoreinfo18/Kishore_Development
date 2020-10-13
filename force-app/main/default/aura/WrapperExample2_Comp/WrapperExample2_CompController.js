({
	doInit : function(component, event, helper) {
       // helper.industryDetails(cmp,event,helper);
         for (var i = 0; i < 42; i++) {
          var cellCmp = component.find(i);
            }
        var firstDayOfWeek = $A.get("$Locale.firstDayOfWeek") - 1; 
       // alert('firstday of week+' +firstDayOfWeek);
        var conDetails = component.get("c.getContactDetails");
        conDetails.setCallback(this,function(allConDetails){
           var state=allConDetails.getState();   
            component.set("v.ContactDetails",allConDetails.getReturnValue());
         //   alert('contact details are ' +JSON.stringify(allConDetails.getReturnValue()));
        });
    $A.enqueueAction(conDetails);
	}
})