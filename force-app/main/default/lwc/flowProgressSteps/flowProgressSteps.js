import { LightningElement, api, track } from 'lwc';

export default class FlowProgressSteps extends LightningElement {

    @api Steps = "Step1,Step2,Step3,Step4,Step5";
    //  @api currentStep = "Step4";
    @api HasError;
    @api ColorHEX;

    firstStepProperty;

    currentStepVal;

    stepsr = [
        { label: 'Contacted', value: 'step-1' },
        { label: 'Open', value: 'step-2' },
        { label: 'Unqualified', value: 'step-3' },
        { label: 'Nurturing', value: 'step-4' },
        { label: 'Closed', value: 'step-5' },
    ];
    @api
    get StepsArray() {
        //alert(this.Steps);
        let StepArray = this.Steps.split(',');
        // alert('StepArray is :' + StepArray + ' current step is :' + this.CurrentStep);
        return StepArray;
        //return this.Steps;
    }
    @api currentStep() {
        return this.currentStepVal;
    }

    set currentStep(value) {
        //alert('current step is :' + this.currentStep + '   ' + value);
        this.currentStepVal = value;
        // return this.currentStepVal;
    }
}