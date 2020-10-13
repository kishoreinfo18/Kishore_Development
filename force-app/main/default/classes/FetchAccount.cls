public class FetchAccount {
    @AuraEnabled
    public static list<Account> getAccounts(String accntId,String AcntName){
        List<Account> accLst=[select AccountNumber,Name,phone,description from account 
                              where AccountNumber =: accntId and Name = : AcntName and AccountNumber!=null and Name!=null and phone!=null];
        return accLst;
    }
}