import { LightningElement } from 'lwc';

export default class Example extends LightningElement {
    renderedCallback() {
        this.template.querySelector('div'); // <div>First</div>
        console.log('kishore in console' + this.template.querySelector('div'));
        this.template.querySelector('span'); // null
        this.template.querySelectorAll('div'); // [<div>First</div>, <div>Second</div>]
    }
}