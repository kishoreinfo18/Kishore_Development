import { LightningElement,track } from 'lwc';
/* eslint-disable no-console */
 /* eslint-disable no-alert */
export default class ContactLwc extends LightningElement {
    @track contactObj = {firstName:'',lastName:'',telephoneNumber:'',email:''};
    @track firstNameError='';
    handleClickSave(event){
        console.log('error displaying3' + this.template.querySelector('[data-id="fName"]').value);
        if(this.template.querySelector('[data-id="fName"]').value == null || this.template.querySelector('[data-id="fName"]').value == ''){
            console.log('error displaying1');
            const fstname = this.template.querySelector('[data-id="fName"]');
            this.firstNameError='First name is required';
            console.log('error displaying2');
        }
        else
        {
            this.firstNameError='';   
        } 
    }
}