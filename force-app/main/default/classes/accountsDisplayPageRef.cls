public with sharing class accountsDisplayPageRef {
public list<Account> acts;
public list<account> getActs()
{
return null;
}
public pageReference BillingCity()
{
 acts=[select name,accountnumber,fax,phone from account where Phone=null];
 return null;
}
public pageReference BillingCityNotNull()
{
 acts=[select name,accountnumber,fax,phone from account where Phone!='null'];
 return null;
}
}