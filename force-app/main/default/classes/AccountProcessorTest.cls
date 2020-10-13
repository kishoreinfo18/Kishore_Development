@isTest
public class AccountProcessorTest {
	@isTest
    public static void countContactsTst(){
        List<id> accntIdLst = new List<Id>();
    	Account acc = new Account(Name='testAccounts');
        insert acc;
        Contact cont = new Contact(accountId=acc.Id,LastName='Contactlastname',firstname='contactfname');
        insert cont;
        for(Account accnt : [select Id from Account]){
        	accntIdLst.add(accnt.Id);
        }
        test.startTest();
        	AccountProcessor.countContacts(accntIdLst);
        test.stopTest();
    }
}