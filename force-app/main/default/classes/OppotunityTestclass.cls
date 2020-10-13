@isTest

private class OppotunityTestclass{

static testmethod void mytestmethod(){
User u = [Select Id,Name,Alias from User where Name='Kishore Reddy' and Alias='kredd'];

system.RunAs(u){
Account acc = new Account();
acc.Name='TestAccount1';
acc.Phone='90876543';
insert acc;

Opportunity opp = new Opportunity ();
opp.Name='TestOpp1';
opp.accountId=acc.Id;
opp.closedate=system.Today();
opp.StageName='Prospecting';
opp.Account_Manager__c ='00590000003gQIL';
opp.OwnerId = '00590000003gQIL';
insert opp;


}
}

}