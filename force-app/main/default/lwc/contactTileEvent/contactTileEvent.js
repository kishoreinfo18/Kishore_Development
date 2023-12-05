import { LightningElement, api } from 'lwc';

export default class ContactTileEvent extends LightningElement {
    @api contact;

    updateContact() {
        this.dispatchEvent(new CustomEvent('updatecontact'));
    }
}