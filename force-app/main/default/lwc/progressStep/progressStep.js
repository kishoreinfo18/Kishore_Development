import { LightningElement, api } from 'lwc';

export default class CurrentProgreeStep extends LightningElement {
    @api label;
    @api currentvalue;
    @api currentkey;
    @api currentStep;

    @api
    get currentstep() {
        alert('currentstep is :' + this.currentStep);
    }
}