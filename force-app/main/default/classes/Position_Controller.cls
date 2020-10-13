public class Position_Controller {
    @AuraEnabled
    public static list<Position__c> findAll(){
        return [select Name,Responsibilities__c,Status__c,Close_Date__c,Job_Type__c from position__c];
    }

}