import { LightningElement,api,track,wire } from 'lwc';
import {CurrentPageReference} from 'lightning/navigation';

export default class RequestType extends LightningElement {
    requestTypeValue; 
    isRequestTypeComponent=true;
    @api cancelButtonName="Cancel";
    isRequestDetailsComponent=false;
    recordId;

    get requestType() {
        return [
            { label: 'Trust & Investment Onboarding', value: 'Trust&InvestmentOnboarding' },
            { label: 'Money Movement', value: 'MoneyMovement' }            
        ];
    }
    get isRequestType(){
        return this.isRequestTypeComponent;
    }
    get isrequestDetails(){
        return this.isRequestDetailsComponent;
    }

    //used to fecth the current page id ie parentId
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.recordId = currentPageReference.state.recordId;
        }
    }

    handleChange(event) {
        this.requestTypeValue = event.detail.value;
    }
    handleContinue(event){
        this.isRequestTypeComponent = false;
        this.isRequestDetailsComponent =true;
    }

    navigateToRequestTypeHandler(event){
        this.isRequestTypeComponent = event.detail;
        this.isRequestDetailsComponent =false;
    }
}