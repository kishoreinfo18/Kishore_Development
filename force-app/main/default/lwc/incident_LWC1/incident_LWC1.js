import { LightningElement, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import Type_FIELD from '@salesforce/schema/Account.Type';

export default class Incident_LWC1 extends LightningElement {
    typeValue = "";
    accntNum = ""; //here decoratory is not used since value is sending from html to javascript
    
    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: Type_FIELD })
    typeValues;

    handleAccntType(event){
        this.accntNum = event.target.value;
    }
    handleChange(event){
        this.typeValue = event.target.value;
    }
}