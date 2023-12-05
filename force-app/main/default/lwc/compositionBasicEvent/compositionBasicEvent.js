import { LightningElement } from 'lwc';

export default class CompositionBasicEvent extends LightningElement {
    contact = {
        Name: 'Amy Taylor',
        Title: 'VP of Engineering',
        Picture: 'https://s3-us-west-1.amazonaws.com/sfdc-demo/people/amy_taylor.jpg',
    };

    handleUpdateContact() {
        console.log('console log is event update ');
        this.contact = {
            Name: 'Michael Jones',
            Title: 'VP of Sales',
            Picture: 'https://s3-us-west-1.amazonaws.com/sfdc-demo/people/michael_jones.jpg',
        };
    }
}