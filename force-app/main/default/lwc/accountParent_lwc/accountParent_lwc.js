import { LightningElement, wire, track } from 'lwc';
import getContactList from '@salesforce/apex/AccountController.getAccountList';
export default class AccountParent_lwc extends LightningElement {
    @track trackValue;
    @wire(getContactList) accounts;
    connectedCallback() {
        console.log('connected callback method');
        this.trackValue = 'Kishore Reddy';
    }
}