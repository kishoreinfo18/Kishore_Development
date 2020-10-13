import { LightningElement,track,api,wire } from 'lwc';
import getAccountNames from '@salesforce/apex/ContactListController.getAccountNames';
export default class ParentToChildChildComponent extends LightningElement {
    @track message;
    @track searchKey = '';
    @wire(getAccountNames,{accntName : '$searchKey'}) accountName;
    @api changeMessage(mesageStr){
        this.message = mesageStr;
    }
    accountfocusValue(event){
        this.searchKey = event.target.label;
        console.log('accountfocusValue'+this.searchKey);
    }
    accountInputValue(event){
        this.searchKey = event.target.value;
        console.log('searchKey'+this.searchKey);
    } 
    handleClick(event) {
        console.log("In handleClick");
    }
}