({
	    getCompnent: function(cmp, evt) {
         alert('componenet id is');
		 var selected = evt.getSource().getLocalId();
        console.log('componenet id is->'+selected);
        cmp.set("v.selectedId",selected);
		
	},
    BackCompnent: function(cmp, evt) {
         alert('componenet id is');
		 var selected = evt.getSource().getLocalId();
        console.log('componenet id is->'+selected);
        cmp.set("v.selectedId",selected);
		
	}
})