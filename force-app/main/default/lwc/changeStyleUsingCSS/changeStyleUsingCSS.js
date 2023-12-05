import { LightningElement, api } from 'lwc';

export default class ChangeStyleUsingCSS extends LightningElement {
    inputValue;
    @api
    get inputValues() {
        alert('input value in getter :' + this.inputValue);
    }
    set inputValues(value) {
        this.inputValue = value;
        alert('input value in setter :' + this.inputValue);
    }
}