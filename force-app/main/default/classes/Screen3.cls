public with sharing class Screen3 {
public Account account{get;set;}
public Screen3()
{
 Id id=apexpages.currentPage().getparameters().get('Id');
 account=[select Id,name,Phone from Account where id=:id];
} 
}