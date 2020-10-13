global class AccountBatchClass implements database.Batchable<sObject>
{
    global dataBase.QueryLocator start(dataBase.BatchableContext BC)
    {
        String qry = 'select Description from account';
        return Database.getQueryLocator(qry);
    }
    global void execute(database.BatchableContext BC, Sobject[] sob)
    {
        List<Account> acclst = new List<Account>();
        for(Sobject accobg:sob )
        {
            Account acnt = (Account)accObg; 
            acnt.description=acnt.description+'    kishore';
            acclst.add(acnt);            
        }
        if(!(acclst.isEmpty()))
        {
            dataBase.update(acclst);
        }
      }
    global void finish(database.BatchableContext BC)
    {
        
    }
}