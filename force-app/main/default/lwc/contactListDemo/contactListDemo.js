import { LightningElement, wire, track } from 'lwc';
/* eslint-disable no-console */
 /* eslint-disable no-alert */
import getContactList from '@salesforce/apex/ContactListController.getContactList';

export default class ContactListDemo extends LightningElement {
    @track contacts="";
    @track errors="";
    @track contname="";
    @wire(getContactList,
        {name : '$contname'})  
    wiredcontact({data,error}){
        if(data){
            this.contacts = data;
            console.log('contacts is:'+contacts);
        }
        else{
            this.errors = error;
        }
        
    }
    contactinputvalue(event){
        this.contname = event.target.value;
        console.log('contName is:'+event.target.value);
    }
}