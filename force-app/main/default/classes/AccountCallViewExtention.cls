public class AccountCallViewExtention {
public Account_Call__C accCall;
public boolean showUnlockButton {get;set;}
public boolean showEditButton {get;set;}
public boolean showCallAttendees{get;set;}
public Boolean show_SAP_Flag_ToAdmin{get;set;}
public String accountAddress{get;set;}
public Id AccountCallId;
public list<String> selectedAdhocActivitiesList{get;set;}
    public AccountCallViewExtention (ApexPages.StandardController controller)
    {
    AccountCallId=ApexPages.currentPage().getParameters().get('Id');
    Try
     {
     accCall=[select id, Status__c, Sub_Status__c, createdById, SAP_EXTRACT_FLAG__c, Adhoc_Activities_CN__c, Adhoc_Activities__c, Account_Calls__c, Account_Calls__r.Name, Start_Date__c, previous_status__c, Call_Type__c, Next_Schedule_Call_Date__c,
                            Account_Calls__r.ShippingAddress, Account_Calls__r.shippingStreet, Account_Calls__r.ShippingCity, Account_Calls__r.ShippingState, Account_Calls__r.ShippingPostalCode, Account_Calls__r.ShippingCountry
                    from Account_Call__c
                    where id = :AccountCallId];
     if(!String.isBlank(accCall.Adhoc_Activities__c)){
             selectedAdhocActivitiesList=accCall.Adhoc_Activities__c.split(';');  
          }            
 
    }
     catch (System.QueryException e) {      
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Record is deleted');
            ApexPages.addMessage(myMsg); 
      }
    }
    public pageReference submit()
    {
    return null;
    }
   List<String> accountAddressField=new List<String>(); 
}