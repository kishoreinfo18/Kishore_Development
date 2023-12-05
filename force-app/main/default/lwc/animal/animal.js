import { LightningElement } from 'lwc';

export default class Animal extends LightningElement {
    name;
    originalAge = 10;
    newAge = 0;

    get age() {
        console.log('In getter :' + this.originalAge);
        return this.originalAge;
    }
    set age(value) {
        console.log('setter value is :' + value);
        this.originalAge = value;
    }

    newAgeUpdate(event) {
        this.newAge = event.target.value;
        console.log('onchange value: ' + this.newAge);
    }
    updateAge(event) {
        console.log('this.newAge in button: ' + this.age);
        this.age = this.newAge;

    }
}