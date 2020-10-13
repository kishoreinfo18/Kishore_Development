public class InlineEditController {
     @AuraEnabled
    public static List <account> fetchAccount() {
        List <Account> lstOfAccount = [select id, Name, Rating, website from account LIMIT 5];
        return lstOfAccount;
    }
    @AuraEnabled
    public static List <account> saveAccount(List<Account> lstAccount) {
        update lstAccount;
        return lstAccount;
    }
    @AuraEnabled
    public static List < String > getselectOptions(sObject objObject, string fld) {
        system.debug('objObject --->' + objObject);
        system.debug('fld --->' + fld);
        List < String > allOpts = new list < String > ();
        Schema.sObjectType objType = objObject.getSObjectType();
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        list < Schema.PicklistEntry > values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        allOpts.sort();
        return allOpts;
    }

}