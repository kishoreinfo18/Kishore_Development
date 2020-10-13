({
	handleClick : function(component, event, helper) {
        debugger;
        var targ = event.getSource();
        alert(targ+"    "+targ.get("v.label"));
		
	}
})