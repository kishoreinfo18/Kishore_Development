import { LightningElement,track,wire } from 'lwc';
export default class Parent_To_ChildCommunication extends LightningElement {
    handleChange(event){
        this.template.querySelector('c-parent-to-child-child-component').changeMessage(event.target.value);
    }
    
}