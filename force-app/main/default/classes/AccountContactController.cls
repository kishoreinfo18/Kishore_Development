public with sharing class AccountContactController {
public account acc{get;set;}
public Contact con{get;set;}

public AccountContactController()
{
 acc=new account();
 acc.name='Kishore';
 con=new Contact();
} 
public pageReference SaveAccountContact()
{
 insert acc;
 con.AccountId=acc.Id;
 insert con;
 pageReference ref=new pageReference('/'+acc.Id);
 ref.setredirect(true);
 return ref;
}
public pageReference CancelAccountContact()
{
  pageReference ref=new PageReference('/apex/vf_AccountContactData');
   ref.setredirect(true);
   return ref;
}
}