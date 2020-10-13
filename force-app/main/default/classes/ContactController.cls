public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        //return[SELECT FirstName,LastName,Email FROM CONTACT WHERE FIRSTNAME != null];
        throw new AuraHandledException('Forced error');
    }
}
