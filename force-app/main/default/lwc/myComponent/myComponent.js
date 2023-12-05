import { LightningElement, api } from 'lwc';
//import { isExternalLink } from "c/helpers";
export default class MyComponent extends LightningElement {
    privateTitle = 'Kishore';

    @api
    get title() {
        alert(' title is my component:' + this.privateTitle);
        return this.privateTitle;
    }

    set title(value) {
        alert('setter value is my component:' + value);
        this.privateTitle = value.toUpperCase();
        //this.setAttribute('title', this.privateTitle);
        //console.log('this.privateTitle valie  is :' + this.privateTitle + '  value    ' + value);
    }
}