public with sharing class AccountCallController {
public final id usId{get; set;}
public Account_call__c AccountCall {get;set;}
public String AccountNumber{ get;set; }
public final string pageUrl{get;set;} 
public string AccountName{get;set;}
public ID accId;
    public AccountCallController(ApexPages.standardController controller)
    {
    Id usId=userInfo.getUserid();
    AccountCall = new Account_call__c();
    system.debug('login user id is:'+usId); 
    pageUrl=apexPages.currentPage().getURL();
    system.debug('current page url is :'+pageUrl);
    system.debug('page url is:'+pageUrl);
    final Integer result = pageUrl.indexOf('_lkid=');
    system.debug('result is :'+result);
    if (result!=-1) {
                AccId = pageUrl.substring(result + 6, result + 6 + 15);
                system.debug('result-->' + result);
                system.debug('id-->' + AccId);
                AccountCall.Account_Calls__c = accId; 
                AccountCall.Duration_Minutes__c='30';
                system.debug('account_calls__c is :'+accountCall.account_calls__c);  
                populateActivities();      
                    }
     }
     public void populateActivities()
     {
     Account acc;
     system.debug('with in method');
      AccountName=[select name from Account where Id =: AccountCall.Account_Calls__c][0].Name;
     system.debug('After method'+AccountName);
     acc=[select accountNumber from account where Id =: AccountCall.Account_Calls__c];
     system.debug('account number is :'+acc.AccountNumber);
     AccountNumber=acc.AccountNumber;
     }
}