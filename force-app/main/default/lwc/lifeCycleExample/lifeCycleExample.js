import { LightningElement, api, wire } from 'lwc';
/* Wire adapter to fetch record data */
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
export default class LifeCycleExample extends LightningElement {
    lists = [];
    varTemp = true;
    @api recordId;
    accountObject = ACCOUNT_OBJECT;
    fields = ['AccountId', 'Name', 'Industry', 'Phone', 'Type'];
    @wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD] })
    record;
    @wire(getRecord, { recordId: '$recordId', fields: [INDUSTRY_FIELD] })
    record;
    @wire(getRecord, { recordId: '$recordId', fields: [TYPE_FIELD] })
    record;
    Constructor() {
        debugger;
        Super();
        console.log('construction is called');
        this.lists.push('Hi Kishore');

    }
    get nameValue() {
        console.log('inside get parament' + getFieldValue(this.record.data, NAME_FIELD));
        return this.record.data ? getFieldValue(this.record.data, NAME_FIELD) : '';
    }
    get industryValue() {
        console.log('inside get parament' + getFieldValue(this.record.data, INDUSTRY_FIELD));
        return this.record.data ? getFieldValue(this.record.data, INDUSTRY_FIELD) : '';
    }
    get typeValue() {
            console.log('inside get parament' + getFieldValue(this.record.data, TYPE_FIELD));
            return this.record.data ? getFieldValue(this.record.data, TYPE_FIELD) : '';
        }
        /* connectedCallback() {
             debugger;
             console.log('connected call back is called');
             this.lists.push('Hi Kishore');
         } */
}