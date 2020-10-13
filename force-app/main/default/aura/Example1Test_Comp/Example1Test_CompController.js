({
	handleClick : function(cmp, event, helper) {
        alert('>>>>>>>1');
		var attr = cmp.get("v.text");
        alert("alert values is"+attr);
        var attr2 = event.getSource();
        alert("event source values is"+attr2);
        alert("event source values is 124 "+attr2.get("v.label"));
         alert("Id values is 124 "+attr2.get("v.id"));
        cmp.set("v.text",attr2.get("v.label"));
        
	}
});