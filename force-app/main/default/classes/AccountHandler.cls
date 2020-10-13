public class AccountHandler
{
    public static void updateExample(list<Account> oldAcc, list<Account> newAcc,Map<id,Account> oldMap, Map<Id,Account> newMap ){
        for(Account acc:oldAcc)
        {
            system.debug('triger of old accounts are ' + acc.name);
            system.debug('triger of old accounts are ' + acc.phone);
        }
        for(Account acc:newAcc)
        {
            system.debug('triger of new accounts are ' + acc.name);
            system.debug('triger of new accounts are ' + acc.phone);
        }
        map<id,Account> oldAccMap = oldMap;
        map<Id,Account> newAccMap = newMap;
        system.debug('old account map details are '+oldAccMap);
        system.debug('new account map details are '+newAccMap);
        
    }
  /*  public static void updateRelatedContactAddress(List<Account> newAccount, map<id,Account> oldMapAccount,map<Id,Account> newAccountmap,boolean isUpdate)
    {
        id accountRecordType='xyzid'; //Schema.SObjectType.Account.getRecordTypeInfosByName().get(recordtype).getRecordTypeId();
        set<id> accId = new set<id>();
        for (Account acc:newAccount)
        {
            if(acc.recordTypeId==accountRecordType)
            {
                Account OldAcc = oldmapAccount.get(acc.Id);
                if(acc.ShippingCity!=oldacc.shippingCity || acc.ShippingState != oldacc.shippingState)
                {
                    accId.add(acc.Id);
                } 
            }
        }
        Contact[] con=[select id,AccountId from contact where accountid in:accId];
        for(Contact cont:con)
        {
             
            cont.mailingCity= newAccountmap.get(cont.AccountId).ShippingCity;
            cont.MailingState= newAccountmap.get(cont.AccountId).ShippingState;
            
        }
        update con;
    }
 /* /*public static void populateSalesRepName(list<Account> acclst)
  {
   set<id> accId=new set<id>();
   for (Account acc:acclst)
   {
    accId.add(acc.ownerId);
   }
   map<Id,User> mapAcc=new map<id,User>([select name from user where Id=:accId]);
   system.debug('Account owner name is '+mapacc);
    for(Account accOwnerId:acclst)
    {
     User usr=mapAcc.get(accOwnerId.OwnerId);
     accOwnerId.Sales_Rep__c=usr.Name;
    }
  } 
  public static void DuplicateAccountNameChk(List<Account> acc)
  {
   set<String> accName=new set<String>();
   for (Account accdetails:acc)
   {
    accName.add(accDetails.Name);
   }
   List<Account> lstName=[select name from account where name in: accName];
   for(Account accDet:lstName)
   {
     if(accdet.name!=null)
     {
      accdet.addError('account name is already exists');
      system.debug('account name is already exists');
     }
   }
 } */
/* public static void AddRelatedRecords(list<Account> accountLst)
 {
  List<Contact> conlst=new list<Contact>();
  map<id,Account> mapaccnt=new map<Id,Account>([SELECT Id,(SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountLst]);
  for(Account acc:accountLst)
  {
  system.debug('Account oppertunities are :'+acc);
  system.debug('Account oppertunities details are :'+mapaccnt.get(acc.Id).Contacts.size());
  if(mapaccnt.get(acc.Id).Contacts.size()==0)
  {
  system.debug('contact name');
    conlst.add(new Contact(LastName='Kishore Reddy',AccountId=acc.Id));
  }
  }
  insert conlst;
 }
 */
 
  /* public static void updateAccntContactDescription(List<Account> lstAcc)
   {
    set<id> accId=new set<Id>();
    for(Account acc:lstAcc)
    {
     accId.add(acc.Id);
    }
    system.debug('Account Id is :'+accId);
    Contact conObject=new Contact();
    list<Contact> lstcon=[select Description from Contact where AccountId in :accId];
    List<Contact> updCont=new List<Contact>();
    system.debug('outside For Loop :'+ lstcon);
    if(!lstcon.isEmpty()){
     for(Contact cont:lstcon)
     {
       conObject=new Contact();
       conObject.Description = 'Account updated on'+''+ date.Today();
       system.debug('Contact description is :'+ conObject.Description);
       system.debug(conObject);
       updCont.add(conObject);
     }
     database.update(updCont,false);
     system.debug('Updated contactes in List is :' + conObject);
     system.debug('Updated contactes in List is :' + updCont);
   }
 }
  public static void accountsegmentation(List<Account> lacc){
   //list<Account_calls__c> lacccalls=[select p1,p2,p3 from Account_calls__c where Account_Calls__c=:lacc];
   Id AccId;
   for(Account acc:lacc)
   {
     accid=acc.Id;
     system.debug('fafaf'+accid);
   }
  }*/
  // @future (callout = true) 
  public static void populateAccountRating(list<Account> plstAcc,Map<id,Account> mapAcc)
  {
      //Account acnt;
      List<Account> lstAccnt= new List<Account>();
      system.debug('parameter list of account are:'+ plstAcc);
      for(Account acc:plstAcc)
      {
          system.debug('Account acc                '+acc.Account_Status__c);
          system.debug('old account Account_Status__c is :'+mapAcc.get(acc.id).Account_Status__c);
          if(Acc.Account_Status__c=='Active' && mapAcc.get(acc.id).Account_Status__c!='Active')
          {
              //acnt= new Account();
             Acc.P1__c='Moist';
             Acc.p2__c='Acuvue';
              lstAccnt.add(Acc);
              system.debug('list values of account is :'+lstaccnt);
          }
      }
      //database.update(lstAccnt);
  }
  public static void populateproductp1p2p3(list<Account> accLst,map<id,Account> mapAcc,map<id,Account> oldmapAcc)
  {
    set<id> accid = new set<id>();
    list<Account_Call__c> prodLstAccCalls = new List<Account_Call__c>();
    
    for(Account acc:acclst)
        {
          accId.add(acc.id);   
        }
    
     
   // map<Id,Account_Call__c> mAccCalls = new map<Id,Account_Call__c>([select id,name,Status__c,p1__c,p2__c,p3__c from Account_Call__c where id in:accId]);
       For(Account acnt:accLst)
       {
           if(acnt.p1__c!=oldmapAcc.get(acnt.id).p1__c || acnt.p2__c!=oldmapAcc.get(acnt.id).p3__c || acnt.p3__c!=oldmapAcc.get(acnt.id).p3__c)
           {
           List<Account_Call__c> mAccCalls = new List<Account_Call__c> ([select id,name,Status__c,p1__c,p2__c,p3__c from Account_Call__c where id in:accId]);
            for(Account_Call__c accCalls : mAccCalls)
            {
                accCalls.p1__c=mapAcc.get(accCalls.Account_Calls__c).p1__c;
                accCalls.p2__c=mapAcc.get(accCalls.Account_Calls__c).p2__c;
                accCalls.p3__c=mapAcc.get(accCalls.Account_Calls__c).p3__c;
                prodLstAccCalls.add(acccalls);
            }
          
          }
         database.update(prodLstAccCalls);    
        }
  }
 }