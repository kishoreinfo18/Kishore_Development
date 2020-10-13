import { LightningElement,wire, track } from 'lwc';
/* eslint-disable no-console */
 /* eslint-disable no-alert */
import CONTACT_SALUTATION from '@salesforce/schema/Contact.Salutation';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
export default class ContactSalutationLwc extends LightningElement {
    @track salutationvalues=''
    @track error='';
    @wire(getPicklistValues, {recordTypeId : '012000000000000AAA', fieldApiName : CONTACT_SALUTATION})
    wiredPickListValue({ data, error }){
       // debugger;
       console.log('Picklist values are '+ data);
        if(data){
            console.log('Picklist values are '+ data);
            this.salutationvalues = data.values;
            var salvale = data.values;
            this.error = undefined;
            console.log('Picklist values are '+ salvale);
        }
        if(error){
            console.log('Error while fetching Picklist values');
            this.error = error;
            this.salutationvalues = undefined;
        }
    }
}