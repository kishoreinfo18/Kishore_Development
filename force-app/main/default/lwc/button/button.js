import { LightningElement, api, wire } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import {
  subscribe,
  unsubscribe,
  APPLICATION_SCOPE,
  MessageContext
} from "lightning/messageService";
import PolicySelectionChannel from "@salesforce/messageChannel/policySelection__c";

let MessageChannel = null;

export default class ButtonPlusLink extends NavigationMixin(LightningElement) {
  @api buttonText;
  @api linkPageApi;
  @api subscriberChannel;
  @wire(MessageContext) context;
  subscription = null;
  targetPageReference;

  handlePublishedMessage = msg => {
    let pageRefCopy;
    switch (this.subscriberChannel) {
      case "policy":
        pageRefCopy = Object.assign({}, this.targetPageReference, {
          state: { c__policy: msg.policyNumber }
        });
        break;
      case "beneficiary":
        break;
      case "claim":
        break;
      default:
      // no default
    }
    if (pageRefCopy) this.targetPageReference = pageRefCopy;
  };

  connectedCallback() {
    switch (this.subscriberChannel) {
      case "policy":
        MessageChannel = PolicySelectionChannel;
        break;
      case "beneficiary":
        // TODO message channel?
        break;
      case "claim":
        // TODO message channel?
        break;
      default:
      // no default
    }

    if (this.subscriberChannel !== "none" && !this.subscription) {
      this.subscription = subscribe(
        this.context,
        MessageChannel,
        message => this.handlePublishedMessage(message),
        { scope: APPLICATION_SCOPE }
      );
    }

    this.targetPageReference = {
      type: "comm__namedPage",
      attributes: {
        name: this.linkPageApi
      }
    };
  }

  clickHandler(evt) {
    evt.preventDefault();
    evt.stopPropagation();
    this[NavigationMixin.Navigate](this.targetPageReference);
  }

  disconnectedCallback() {
    unsubscribe(this.subscription);
    this.subscription = null;
  }
}
