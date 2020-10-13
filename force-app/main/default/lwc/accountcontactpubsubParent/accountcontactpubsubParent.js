import { LightningElement,wire,track } from 'lwc';
/* eslint-disable no-console */
 /* eslint-disable no-alert */
import getAccountNames from '@salesforce/apex/ContactListController.getAccountNames';
import { fireEvent } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
export default class AccountcontactpubsubParent extends LightningElement {
    @wire(getAccountNames,{accntName : '$searchKey'}) accountName;
    @track searchKey = 'Enter Account Name';
    @wire(CurrentPageReference) pageRef;
    accountInputValue(event){
        this.searchKey = event.target.value;
        console.log('searchKey'+this.searchKey);
    } 
    handleSearchAccount(event){
        let accntlabelName = event.target.label;
        console.log('accntlabelName is:'+accntlabelName);
        fireEvent(this.pageRef,'searchKey',this.searchKey);
    }
    accountfocusValue(event){
        console.log('searchKey is:'+this.searchKey);
    }
}