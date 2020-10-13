import { LightningElement, api } from 'lwc';

export default class CardOuter extends LightningElement {
    @api enableHover;
    get classNames() {
        const hoverClass = this.enableHover === "true" ? 'hoverable' : '';
        const classes = `outer_container slds-p-around_medium ${hoverClass}`.trim();
        return classes;
    }
}