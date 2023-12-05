import { LightningElement, api } from 'lwc';

export default class ContactTile extends LightningElement {
    @api contact;

    updateContact() {
        console.log('console log is ');
        this.dispatchEvent(new CustomEvent('updatecontact'));
    }
}