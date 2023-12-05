import { LightningElement, wire, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { openTab, focusTab,EnclosingTabId, getTabInfo, openSubtab,getFocusedTabInfo,IsConsoleNavigation,refreshTab  } from 'lightning/platformWorkspaceApi';
import { FlowNavigationFinishEvent } from 'lightning/flowSupport';

export default class FlowRedirect extends NavigationMixin(LightningElement) {
    @api recordId;
    @api ScreenType;
    @wire(EnclosingTabId) tabId;
    @wire(IsConsoleNavigation) isConsoleNavigation;

    connectedCallback() {
        this.redirectUser();
    }

    redirectUser() {
        if(this.ScreenType.toUpperCase() == 'NEW'){
            if(this.isConsoleNavigation){
                this.redirectUserToConsoleNewTab();
            }
            else if(!this.isConsoleNavigation){
                this.redirectUserToNewBrowserTab();
                this.handleRefresh();
            }
        }
        if(this.ScreenType.toUpperCase() == 'SUB'){
            if(this.isConsoleNavigation){
                this.redirectUserToConsoleNewSubTab();
            }
            else if(!this.isConsoleNavigation){
                this.redirectUserToNewBrowserTab();
                this.handleRefresh();
            }
        }
        if(this.ScreenType.toUpperCase() == 'EXISTING' || (this.ScreenType.toUpperCase() != 'EXISTING'
                                                            && this.ScreenType.toUpperCase() != 'NEW'
                                                            && this.ScreenType.toUpperCase() != 'SUB')){
            if(this.isConsoleNavigation){
                this.redirectUserToSameTab();
            }
            else if(!this.isConsoleNavigation){
                this.redirectUserToSameTab();
            }
        }

    }

    //Below method is used for open new tab in console.
    redirectUserToConsoleNewTab() {
        openTab({
            recordId:this.recordId,
            focus: true
        }).catch((error) => {
            console.log(error);
        });
        
    }

    //Below method is used for open new tab in standard.
    redirectUserToNewBrowserTab(){
        this[ NavigationMixin.GenerateUrl ]( {
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                actionName: 'view',
            },
        } ).then( url => {
            let completeURL = window.location.origin + url;
            let windowFeatures = "menubar=no,resizable=yes,scrollbars=yes";
            windowFeatures  = "width=" + screen.width;
            windowFeatures += ",height=" + screen.height;
            window.open( completeURL, "_blank");
        } );
    }

     //Below method is used for open sub tab in console.
     async  redirectUserToConsoleNewSubTab(){
        let focusedTab = await getFocusedTabInfo();
        
        if (!focusedTab.tabId) {
            return;
        }
        const tabInfo = await getFocusedTabInfo()
        const primaryTabId = tabInfo.isSubtab ? tabInfo.parentTabId : tabInfo.tabId;
        // Open a record as a subtab of the current tab
        openSubtab(focusedTab.tabId, { recordId: this.recordId, focus: true });
    }

    //This method is used for redirecting the user to same existing tab
    redirectUserToSameTab(){
        this[ NavigationMixin.GenerateUrl ]( {
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.recordId,
                    actionName: 'view',
                },
            } ).then( url => {
                let completeURL = window.location.origin + url;
                let windowFeatures = "menubar=no,resizable=yes,scrollbars=yes";
                windowFeatures  = "width=" + screen.width;
                windowFeatures += ",height=" + screen.height;
                window.open( completeURL, "_self");
            } );
    }

    handleRefresh() {
        const navigateNextEvent = new FlowNavigationFinishEvent();
                this.dispatchEvent(navigateNextEvent);
    }

}