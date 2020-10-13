({
    fruitsTab: function(component, event, helper) {
        helper.clearAll(component, event);
        //make fruits tab active and show tab data
        component.find("fruitId").getElement().className = 'slds-tabs--scoped__item slds-active customClassForTab';
        component.find("fruTabDataId").getElement().className = 'slds-tabs--scoped__content slds-show customClassForTabData';
    },
    vegeTab: function(component, event, helper) {
        helper.clearAll(component, event);
        //make vegetables tab active and show tab data
        component.find("VegeId").getElement().className = 'slds-tabs--scoped__item slds-active customClassForTab';
        component.find("vegeTabDataId").getElement().className = 'slds-tabs--scoped__content slds-show customClassForTabData';
    },
    colorTab: function(component, event, helper) {
        helper.clearAll(component, event);
        //make color tab active and show tab data
        component.find("ColorId").getElement().className = 'slds-tabs--scoped__item slds-active customClassForTab';
        component.find("ColorTabDataId").getElement().className = 'slds-tabs--scoped__content slds-show customClassForTabData';
    },
 
})