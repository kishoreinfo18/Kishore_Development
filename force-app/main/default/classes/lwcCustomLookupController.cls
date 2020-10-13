public with sharing class lwcCustomLookupController {
    public lwcCustomLookupController() {

    }

    @AuraEnabled(cacheable=true)
    public static List<SObJectResult> getResults(String ObjectName, String fieldName, String value) {
        List<SObJectResult> sObjectResultList = new List<SObJectResult>();
        system.debug(fieldName+'-------------'+ObjectName+'---++----------'+value);
        if(String.isNotEmpty(value))
            for(sObject so : Database.Query('Select Id,'+fieldName+' FROM '+ObjectName+' WHERE '+fieldName+' LIKE \'%' + value + '%\'')) {
                String fieldvalue = (String)so.get(fieldName);
                sObjectResultList.add(new SObjectResult(fieldvalue, so.Id));
            }
        
        return sObjectResultList;
    }
    
    public class SObJectResult {
        @AuraEnabled
        public String recName;
        @AuraEnabled
        public Id recId;
        
        public SObJectResult(String recNameTemp, Id recIdTemp) {
            recName = recNameTemp;
            recId = recIdTemp;
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<User> getUsers(String searchUser){
        String srchKey = '%'+searchUser+'%';
        system.debug('srchKey'+srchKey);
        List<User> userLst = [SELECT Id,Name FROM User WHERE Name Like :srchKey];
        system.debug('userLst is:'+userLst);
        return userLst;

    } 
}