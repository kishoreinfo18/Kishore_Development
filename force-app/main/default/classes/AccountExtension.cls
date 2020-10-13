public with sharing class AccountExtension {
public Account acct;
public List<Account> acc;
public selectOption[] accDetails{get;set;}

    public AccountExtension(ApexPages.StandardController controller) {
    system.debug('kishore Reddy');
    this.acct=(Account)Controller.getRecord();
    acc=[select id,name from account];
      accDetails = new list<selectOption>();  
      for(Account accnt:acc){
          system.debug('');
        accDetails.add(new SelectOption(accnt.id,accnt.Name));
      }
    }
    
    public String getGreeting() {
    return 'Hello ' + acct.name + ' (' + acct.id + ')';
    }
    
}