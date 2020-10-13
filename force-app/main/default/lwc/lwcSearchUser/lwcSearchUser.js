import { LightningElement, wire,track } from 'lwc';
/* eslint-disable no-console */
 /* eslint-disable no-alert */
import getUsers from '@salesforce/apex/lwcCustomLookupController.getUsers'
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import SALUTATION_FIELD from '@salesforce/schema/Contact.Salutation';
export default class LwcSearchUser extends LightningElement {
    //@wire(getUsers,{}) userDetails;
    @wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: SALUTATION_FIELD })
    SalutationValues;
    @track userDetails;
    @track error;
   // usersearch="";
   @track searchKey;
   @track focVar = true;
    accountInputValue(event){
        this.focVar=true;
        var usersearch = event.target.value;
        console.log('this.usersearch :'+usersearch);
        getUsers({searchUser : usersearch})
        .then(result => {
            this.userDetails = result;
        })
        .catch(error => {
            this.error = error;
        });
        console.log('this.userDetails:'+this.userDetails);
    }
    setSelectedRecord(event){
        var indx = event.currentTarget.dataset.Id;
        console.log('ev.currentTarget.dataset'+event.currentTarget.dataset.name);
        this.searchKey = event.currentTarget.dataset.name;
        this.focVar=false;
    }
    handleRemoveSelectedOption() {
        this.template
            .querySelector('.selectedOption')
            .classList.add('slds-hide');
        this.template
            .querySelector('.slds-combobox__form-element')
            .classList.remove('slds-input-has-border_padding');

        this.showAccountsListFlag = false;
    }
}