import { LightningElement,wire,track } from 'lwc';
import { registerListener, unregisterAllListeners } from 'c/pubsub';
import getContactBasedonAccount from '@salesforce/apex/ContactListController.getContactBasedonAccount';
import { CurrentPageReference } from 'lightning/navigation';
const columns =[
     { label: 'Firstname', fieldName: 'FirstName', editable: true, type: 'String' },
     { label: 'Lastname', fieldName: 'Lastname' ,type: 'String'},
     { label: 'Email', fieldName: 'Email' ,type: 'String'}
    ];
export default class SearchAccount extends LightningElement {
    @track searchKey;
    @wire(CurrentPageReference) pageRef;
    @wire(getContactBasedonAccount,{accntName : '$searchKey'}) contactDetails;
    @track columns = columns;
    connectedCallback() {
        registerListener('searchKey',this.handleSearchKeychange,this)
    }
    disconnectedCallback(){
        unregisterAllListeners(this);
    }
    handleSearchKeychange(searchKey){
        this.searchKey = searchKey;
        console.log('listner event is :'+this.searchKey);
    }
}