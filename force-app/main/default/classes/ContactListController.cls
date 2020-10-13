public with sharing class ContactListController {
    public ContactListController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Sobject> getContactList(String name){
        String key = '%'+name+'%';
        String strQuery = 'SELECT Id,Name,Email,Phone FROM Contact where name like :key';
        return database.query(strQuery);
    }
    @AuraEnabled(cacheable=true)
    public static List<Sobject> metgetAccountList(String Name){
        String key = '%'+Name+'%';
        String strQuery = 'SELECT Id,Name,Industry FROM Account  WHERE Name LIKE :key';
        return database.query(strQuery);
    }
    @AuraEnabled(cacheable=true)
    public static string getAccountName (){
       String accntname =  'United Oil & Gas Corp.';//[SELECT Name FROM Account WHERE Name =:'United Oil & Gas Corp.' limit 1].Name;
       return accntname;
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountNames(String accntName){
        String key = '%'+accntName+'%';
        return [SELECT Id,Name,AccountNumber FROM ACCOUNT Where Name like :key];
    }  
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactBasedonAccount(String accntName){
        List<Contact> contactLst = new List<Contact>();
        String key = '%'+accntName+'%';
        String AccountId = [SELECT Id,Name,AccountNumber FROM ACCOUNT Where Name like :key limit 1].Id;
        if(AccountId!=null || AccountId!='' || String.isNotEmpty(AccountId)){
            contactLst = [SELECT Id,FirstName,LastName,Email FROM Contact WHERE AccountId = :AccountId];
        }
        return contactLst;
           
    }
}