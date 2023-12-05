import { LightningElement,api } from 'lwc';
import { CloseActionScreenEvent } from "lightning/actions";
export default class CancelButton extends LightningElement {
    @api buttonText;
    cancelHandler(){
        this.dispatchEvent(new CustomEvent('lightning__actionsclosescreen', {bubbles:true, composed:true}))
    }

}   