import { LightningElement, api } from 'lwc';
import SSP_RESOURCES from '@salesforce/resourceUrl/ssp';

export default class PageNavigationCardGrid extends LightningElement {
    @api policiesApiName;
    @api claimApiName;
    @api referFriendApiName;
    @api personalDetailsApiName;
    @api claimHistoryApiName;
    @api helpApiName;

    @api policiesTitle;
    @api claimTitle;
    @api referFriendTitle;
    @api personalDetailsTitle;
    @api claimHistoryTitle;
    @api helpTitle;

    policiesSvgUrl = SSP_RESOURCES + '/images/piggy_bank_80.svg#piggy_bank_80';
    claimSvgUrl = SSP_RESOURCES + '/images/payment.svg#Page-1';
    referFriendSvgUrl = SSP_RESOURCES + '/images/icon-referafriend.svg#Home-UI';
    personalDetailsSvgUrl = SSP_RESOURCES + '/images/profile-80.svg#Icon/SH/profile-80';
    claimsSvgUrl = SSP_RESOURCES + '/images/receipt.svg#Page-1';
    helpSvgUrl = SSP_RESOURCES + '/images/information_book.svg#Page-1';


}