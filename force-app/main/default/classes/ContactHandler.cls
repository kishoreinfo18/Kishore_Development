public class ContactHandler
 {
  public static void ContactDuplicateEmail(list<contact> newCont)
   {
     list<contact> cEmail=[select Id,email from contact];
     map<Id,Contact> mapCont=new map<Id,Contact>();
     for(Contact con:cEmail)
     {
       mapCont.put(con.Id,con);
       for(Contact lstCont:newCont)
        {
         Contact contEmail=mapCont.get(Con.ID);
      system.debug('Contact meail is '+contEmail);
      system.debug('List Contact meail is '+lstcont.Email);
      if(contEmail.Email==lstCont.Email) 
      { 
      system.debug('Not entering into last for loop');
      lstCont.addError(' Email is already existed to another customer   ');
      } 
     }     
   }
  }
   /* ---------------------createing the contact relation ship records--------------*/
   public static void newContactRelationshipRecord(List<Contact> lstcon)
   {
    if(trigger.isInsert || trigger.isUpdate)
    {
    Contact_Relationship__c conrel=new Contact_Relationship__c();
    List<Contact_Relationship__c> lstContRel=new list<Contact_Relationship__c>();
    for(Contact con:lstcon)
    {
     if(con.Contact_Relationship__c==true)
     {
      //conrel.Contact_Name__c=con.LastName;
      conrel.Name=con.LastName;
      conrel.Contact__c=con.Id;
      lstContRel.add(conrel);
     }
    }
    database.insert(lstContRel,false);
     }
     if(trigger.isDelete)
     {
     try{
      Set<Id> conId=new set<Id>();
      for(Contact c:lstcon)
      {
       conId.add(c.Id);
      }
      List<Contact_Relationship__c> crel;
      crel= [select id from Contact_Relationship__c where contact__C=:conId];
      delete crel;
      }
      catch(exception e)
      {
       system.debug('catch the null pointer exception');
      }
     }
    }
   /* -------------Rollupsummary----------------------*/
   public static void RollupContactsOfAccount(List<Contact> newCont, List<Contact> oldCont)
   {
   set<id> AccId=new set<Id>();
    list<Account> accLst=new list<Account>();
    map<Id,Integer> mapAcc=new map<Id,Integer>();
    if(trigger.isInsert || trigger.isUpdate )
    {
     for(Contact cont:newCont)
     {
      accId.add(cont.AccountId);
     }
    }
    if(trigger.isUpdate || trigger.isDelete)
    {
     for(Contact cont:oldCont)
     {
      accId.add(cont.AccountId);
     }
    }
     accLst=[select id,name,(select id from contacts) from account where id=:accId];
     for(Account acc:accLst)
     {
     mapacc.put(acc.Id,acc.Contacts.Size());
     }
     for(Account accnt:accLst)
     {
         accnt.No_of_Contacts__c=mapacc.get(accnt.Id);
     }
     update accLst;
    }
    public static void AssignToDummyAccount(List<contact> lstCont,map<Id,Contact> oldContactMap,boolean isBefore,Boolean isUpdate)
    {
     List<user> adminUser=[select id,Name,profileId,profile.name from user where profile.name=' System Administrator' AND IsActive = TRUE LIMIT 1];
     if(isBefore == true && isUpdate == true)
     {
       List<Account> lstacc=[select id,name from account];
       if(!lstacc.isEmpty())
       {
        for(Contact con:lstCont)
        {
         if(con.Inactive__c==true)
         {
             ID tempId=con.AccountId;
             con.AccountId = null;
             con.AccountId = lstacc[0].id;
             con.OwnerId = adminUser[0].Id;
         }
        }
       }
       else{
               Account unAssignedAccount=new Account();
                unAssignedAccount.name='unAssigned Account';
                unAssignedAccount.Type='Prospect';
                unAssignedAccount.shippingCity='unassigned';
                unAssignedAccount.shippingState='unassigned';
                unAssignedAccount.OwnerId = adminUser[0].Id;
                insert unAssignedAccount;
                for(Contact c: lstCont)
                {
                 if(c.Inactive__c == true) {
                   c.AccountId = unAssignedAccount.Id;
                   c.OwnerId = adminUser[0].Id;
                  }
                }
                
            }
     }
     
    }
    public static void deleteInactiveConInAccntContactRole(List<Contact> inactCont)
    {
      Set<Id> ContId= new set<Id>();
      List<AccountContactRole__c> delAccCon=new list<AccountContactRole__c>();
      for( Contact con:inActCont)
          {
           if(con.inActive__C)
           {
           contId.add(con.Id); 
           }
          } 
          List<AccountContactRole__C> accConRole=[select Id from accountContactRole__C where Contact__C in:contId];
            if(!accConRole.isEmpty())
             {
               for(AccountContactRole__C delac:accConRole)
                {
                 delAccCon.add(delac);
                }
             }
             database.delete(delAccCon,false);                 
    }
}