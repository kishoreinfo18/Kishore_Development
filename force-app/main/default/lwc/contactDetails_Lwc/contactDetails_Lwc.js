import { LightningElement,wire,track } from 'lwc';
/* eslint-disable no-console */
 /* eslint-disable no-alert */
import SimplyhealthLogo from '@salesforce/resourceUrl/SimplyhealthLogo';
import getAccountName from '@salesforce/apex/ContactListController.getAccountName';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import SALUTATION_FIELD from '@salesforce/schema/Contact.Salutation';
export default class ContactDetails_Lwc extends LightningElement {
    simplyheathlogovar = SimplyhealthLogo;
    @wire(getAccountName) accountName;
    @track modalWindow=false;
    @track SalutationValues;
    menuItems = [
        {
            label: 'My Account',
            name: '1',
            expanded: true,
            items: [],
        },
        {
            label: 'My policies',  
            name: '2',
            expanded: true,
            items: [
                {
                    label: 'Optimize health plan',
                    name: '3',
                    expanded: true,
                    items: [],
                },
            ],    
        },
        {
            label: 'Make a claim online',  
            name: '4',
            expanded: true,    
        },
        {
            label: 'My account settings',  
            name: '5',
            expanded: true,
            items: [
                {
                    label: 'Personal details',
                    name: '6',
                    expanded: true,
                    items: [],
                },
                {
                    label: 'Security settings',
                    name: '7',
                    expanded: true,
                    items: [],
                },
            ],    
        },
        {
            label: 'Refer a friend',  
            name: '8',
            expanded: true,    
        },
        {
            label: 'Help and FAQs',  
            name: '9',
            expanded: true,    
        }
    ]
    @wire(getPicklistValues, {recordTypeId: '012000000000000AAA', fieldApiName: SALUTATION_FIELD})
    SalutationValue({ data, error }){
        if(data){
            console.log(` Picklist values are `, data.values);
            this.SalutationValues = data.values;
            this.error = undefined;
        }
        if(error){
            console.log(` Error while fetching Picklist values  ${error}`);
            this.error = error;
            //this.pickListvalues = undefined;
        }
    }
   
    handleLoad(event){
        console.log('accountName is:'+event.target.label);
        console.log('SalutationValues'+SalutationValues.data);
        this.modalWindow = true;
        console.log('this.modalWindow '+this.modalWindow);
    }
    handleClick(event){
        alert('kishore ');
       /* auth0.logout({
            returnTo: window.location.origin
          }); */
         // sessionStorage.clear();
        //https://YOUR_DOMAIN/v2/logout
        window.location.replace("https://kishoredevlwccomm-developer-edition.ap7.force.com/secur/logout.jsp?retUrl=https://kishoredevlwccomm-developer-edition.ap7.force.com/login");
        //window.location.replace("https://simplyhealth-consumer-dev.auth.us-east-2.amazoncognito.com/logout?response_type=code&client_id=76bfrmkbifedij0qn5tjatu6ao&redirect_uri=https%3A%2F%2Fdevelop-simplycommunities.cs102.force.com%2Fservices%2Fauthcallback%2FAWS_Cognito_Consumer_Portal&state=CAAAAXHPRVauME8wMWowMDAwMDAwMDA2AAAA3kt4Yh4nv-G2P2jXtrAFNugPUtAZ-nX1eNNIfjFCd9uqOzHD3y-QL2gvbqzFZ2GYOOGmYCLgOAyjcKpjhtV8VkGE6GWlBiosE-MZFuaDp2GbJgbpmyJw4_v6aAq0pv9nY0zihPnyAlzrurniAACovmZEJbwjakKOevFudf1PJJpXwkj-_sYfLd0V0piL5xCspVwJRYayUJAAenx3toLNak6YyWoEzDGlhHs9JlOOisotEJXSCLnkUp4rbyuWXek_FqjFI0wh68klsbIq1e1YDDU%3D&scope=openid");
        alert('kishore 2');
        //return new Pagereference('/secure/logout.jsp');
    }
}