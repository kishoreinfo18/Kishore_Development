import { LightningElement, api } from "lwc";
import SSP_RESOURCES from "@salesforce/resourceUrl/ssp";

export default class Footer extends LightningElement {
  footerLogoUrl =
    SSP_RESOURCES + "/images/simplyhealth_logo_and_title.svg#SH-Logo";
  linkedinLogo = SSP_RESOURCES + "/images/linkedin.png";
  facebookLogo = SSP_RESOURCES + "/images/facebook.png";
  instagramLogo = SSP_RESOURCES + "/images/instagram.png";
  twitterLogo = SSP_RESOURCES + "/images/twitter.png";
  youtubeLogo = SSP_RESOURCES + "/images/youtube.png";
  @api firstTitle;
  @api firstUrl;
  @api secondTitle;
  @api secondUrl;
  @api thirdTitle;
  @api thirdUrl;
  @api fourthTitle;
  @api fourthUrl;
  @api fifthTitle;
  @api fifthUrl;
  @api sixthTitle;
  @api sixthUrl;
  @api seventhTitle;
  @api seventhUrl;
  @api eigthTitle;
  @api eigthUrl;
  @api ninthTitle;
  @api ninthUrl;
  @api tenthTitle;
  @api tenthUrl;
  @api maxWidth;
  @api fontColor;
  currentYear = new Date().getFullYear();

  get maximumWidth() {
    return `max-width:${this.maxWidth}px`;
  }

  get footerFontColor() {
    return `color:${this.fontColor} !important`;
  }
}