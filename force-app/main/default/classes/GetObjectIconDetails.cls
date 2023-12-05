/*
Class Name : GetObjectIconDetails
Author     : persistent
Description : For populating object Icons. 
*/
public with sharing class GetObjectIconDetails {
    @AuraEnabled(cacheable=true)
    public static  Map<String,String> getIconDetails(String sObjectName) {
        String IconDetails;
        String iconStyle;
        String iconURL;
        String iconTag;
        Map<String,String> iconPropertyMap = new Map<String,String>();
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();
        List<Schema.DescribeTabResult> tabResult = new List<Schema.DescribeTabResult>();
        List<Schema.DescribeIconResult> iconResult = new List<Schema.DescribeIconResult>();
        for(Schema.DescribeTabSetResult tsrObj : tabSetDesc) { 
            tabResult.addAll(tsrObj.getTabs()); 
        }
        for(Schema.DescribeTabResult tr : tabResult) {
            if( sObjectName == tr.getSobjectName() ) {
                if(!tr.getIcons().isEmpty()){
                    iconResult.addAll(tr.getIcons());
                }
                else
                {
                        if( tr.isCustom() == true ) {
                        iconStyle = 'slds-icon-standard-custom'; iconURL   = '/img/icon/t4v35/standard/custom_120.png';
                    	}else {
                        iconStyle = 'slds-icon-standard-' + sObjectName.toLowerCase();iconURL   = '/img/icon/t4v35/standard/' + sObjectName.toLowerCase() + '_120.png';
                    	}
                }
            }
        } //for loop ended here
        for (Schema.DescribeIconResult ir : iconResult) {
            if(ir.getTheme() =='custom' && !ir.getContentType().startsWith('image/svg')){
                iconTag   = 'custom';
                iconURL   = ir.getURL();iconStyle = 'slds-icon-standard-custom';break;
            }
            else if(ir.getWidth() == 120 && ir.getTheme() =='theme4' && ir.getContentType() == 'image/png'){
                if(ir.getURL().contains('/custom/')){
                    iconTag    = ir.getURL().substringBetween('custom/','.png').substringBefore('_');
                    iconURL    = '/img/icon/t4v35/custom/' + iconTag + '_120.png';
                    iconStyle  = 'slds-icon-custom-'+ iconTag;
                    break;
                }else if(ir.getURL().contains('/standard/')){ //Icon is from the Standard Sprite
                    iconTag    = ir.getURL().substringBetween('standard/','.png').substringBefore('_');
                    iconURL    = '/img/icon/t4v35/standard/' + iconTag + '_120.png';
                    iconStyle  = 'slds-icon-standard-'+ iconTag;
                    break;
                }
            }
        }
        //if no icons are found, just default to the Custom lightning icon
        if(iconStyle == null){
            iconStyle = 'slds-icon-standard-custom';
            iconURL   = '/img/icon/t4v35/standard/custom_120.png';
            iconTag   = 'No Lightning Icon Found';
        }
        //return a map with our properties for the front end
        iconPropertyMap.put('iconStyle',iconStyle);
        iconPropertyMap.put('iconURL',  iconURL);
        system.debug('iconPropertyMap is :'+iconPropertyMap);
        return iconPropertyMap;
    }
}