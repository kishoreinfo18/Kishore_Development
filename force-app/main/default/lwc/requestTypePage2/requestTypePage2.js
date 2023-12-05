import { LightningElement,api,track } from 'lwc';
import createCase from '@salesforce/apex/CreateCaseWithFiles.createCase';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from "lightning/actions";
export default class RequestTypePage2 extends LightningElement {
    @api cancelButtonName="Cancel";
    @api requestTypeValue;
    @api parentRecordId;
    @track filesUploaded = [];
    _isInvestmentOnboardingRequestType=false;
    _isMoneyMovement = false;
    accountTypeValue;
    fundingTypeValue;
    priorityValue;
    additionalDetails;
    caseNumber;

    get isInvestmentOnboardingRequestType(){
        if(this.requestTypeValue == "Trust&InvestmentOnboarding"){
            return this._isInvestmentOnboardingRequestType = true;
        }
    }
    get isMoneyMovement(){
        if(this.requestTypeValue == "MoneyMovement"){
            return this._isMoneyMovement = true;
        }
    }
    get accountTypeOptions() {
        return [
            { label: 'Investment', value: 'Investment' },
            { label: 'IRA', value: 'IRA' },
            { label: 'Trust', value: 'Trust' }          
        ];
    }

    get fundingTypeOptions(){
        return [
            { label: 'External Bank', value: 'ExternalBank' },
            { label: 'Cash', value: 'Cash' },
            { label: 'Transfer', value: 'Transfer' }          
        ];

    }
    get priorityOptions(){
        return [
            { label: 'Standard', value: 'Standard' },
            { label: 'Urgent', value: 'Urgent' }         
        ];
    }

    handleAccountTypeChange(event) {
        this.accountTypeValue = event.detail.value;
    }

    handleFundingTypeChange(event){
        this.fundingTypeValue = event.detail.value;
    }

    handlePriorityChange(event){
        this.priorityValue = event.detail.value;
    }

    handleChange(event){
        this.additionalDetails = event.target.value;
    }

    handleGoBack(event){
        this.dispatchEvent(new CustomEvent('navigatetorequesttype',{detail: true }));
    }

    //used to create store the file
    handleFileUpload(event){
        if (event.target.files.length > 0) {
            let files = [];
            for(var i=0; i< event.target.files.length; i++){
                let file = event.target.files[i];
                let reader = new FileReader();
                reader.onload = e => {
                    let base64 = 'base64,';
                    let content = reader.result.indexOf(base64) + base64.length;
                    let fileContents = reader.result.substring(content);
                    this.filesUploaded.push({PathOnClient: file.name, Title: file.name, VersionData: fileContents});
                };
                reader.readAsDataURL(file);
            }
        }
    }

    //create a case
    handleCreateServiceRequest(event){
        //var fundingAmount = this.template.querySelectorAll(".FundingAmount");
        
        if(this.template.querySelector('lightning-input[data-name="FundingAmount"]') != null){
            var fundingAmountValue = this.template.querySelector('lightning-input[data-name="FundingAmount"]').value;
        }
        if(this.template.querySelector('lightning-input[data-name="fromAccount"]') != null){
            var fromAccount = this.template.querySelector('lightning-input[data-name="fromAccount"]').value;
        }
        if(this.template.querySelector('lightning-input[data-name="toAccount"]') != null){
            var toAccount = this.template.querySelector('lightning-input[data-name="toAccount"]').value;
        }
        if(this.template.querySelector('lightning-input[data-name="transferAmount"]') != null){
            var transferAmount = this.template.querySelector('lightning-input[data-name="transferAmount"]').value;
        }
                
        var caseObj = {
            accountId : this.parentRecordId,
            requestType : this.requestTypeValue,
            accountType : this.accountTypeValue,
            fundingType : this.fundingTypeValue,
            fundingAmount : fundingAmountValue,
            priority: this.priorityValue,
            additionalDetails : this.additionalDetails,
            fromAccount : fromAccount,
            toAccount : toAccount,
            transferAmount : transferAmount
        };

        createCase({caseDetails:JSON.stringify(caseObj),files:this.filesUploaded})
        .then(result => {
            if(result != null) {
                console.log('Data:'+ JSON.stringify(result));
                this.caseNumber = result
                this.showToastMessage('Success','case number is: ', 'success');
                this.closeQuickAction();
            }
            
        }) .catch(error => {
            console.log(error);
            this.error = error;
        });
        
    }

    closeQuickAction() {
        this.dispatchEvent(new CustomEvent('lightning__actionsclosescreen', {bubbles:true, composed:true}))
    }

    showToastMessage(title,message,variant){
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message+this.caseNumber,
                variant: variant
            })
        );
    }
}