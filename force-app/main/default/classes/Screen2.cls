public with sharing class Screen2 {
public Account account{get;set;}

public Screen2()
{
 Id id=apexpages.currentPage().getparameters().get('id');
 account=[select Id,name,Phone from Account where id=:id];
} 
public pageReference Save()
{
 Update Account;
 pageReference pr=new pageReference('/apex/screen3?id='+account.id);
 return pr; 
 }
}