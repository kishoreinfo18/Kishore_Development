import { LightningElement, api } from "lwc";
import { NavigationMixin } from "lightning/navigation";

export default class PageNavigationCard extends NavigationMixin(
    LightningElement
) {
    @api title;
    @api apiName;
    @api svgUrl;

    // This isn't used to navigate. It is added to <a> so it can be seen by browser. ie. on hover.
    targetUrl;
    targetPageReference;

    connectedCallback() {
        this.targetPageReference = {
            type: "comm__namedPage",
            attributes: {
                name: this.apiName,
            }
        };
        this[NavigationMixin.GenerateUrl](this.targetPageReference)
            .then(url => {
                this.targetUrl = url;
            });
    }

    handleOnClick(evt) {
        evt.preventDefault();
        evt.stopPropagation();
        this[NavigationMixin.Navigate](this.targetPageReference);
    }
}