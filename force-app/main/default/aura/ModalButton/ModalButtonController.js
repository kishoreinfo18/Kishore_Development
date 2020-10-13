({
    /**
     * Webkul Software.
     *
     * @category  Webkul
     * @author    Webkul
     * @copyright Copyright (c) 2010-2016 Webkul Software Private Limited (https://webkul.com)
     * @license   https://store.webkul.com/license.html
    **/
    getCompnent: function(cmp,event) {
        //Create component dynamically
        $A.createComponent(
            "c:Modal",{},
            function(newcomponent){
                if (cmp.isValid()) {
                    var body = cmp.get("v.body");
                    body.push(newcomponent);
                    cmp.set("v.body", body);             
                }
            }            
        );
    },
    removeComponent:function(cmp,event){
        //get the parameter you defined in the event, and destroy the component
        var comp = event.getParam("comp");      
        comp.destroy();
    },
})