import { LightningElement, api, track } from 'lwc';

export default class GetterSetter extends LightningElement {

    defaultMsg = "We are learning ";
    @track outputMessage;

    @api
    get message() {
        alert('getter');
        return this.defaultMsg + "Lightning Web Component";

    }

    set message(val) {
        alert('setter');
        this.outputMessage = val;
    }

    handleMessage(event) {
        alert('hadlemessages');
        this.message = event.target.value;
    }

    connectedCallback() {
        alert('connectedcallback url');
    }
}