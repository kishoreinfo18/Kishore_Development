public class AccountProcessor{
    @future
    public static void countContacts(List<Id> accntIdsLst){
        List<Account> accntLst = new List<Account>();
        for(AggregateResult aResult : [SELECT Count(Name) cnt,AccountId FROM Contact Where AccountId IN :accntIdsLst GROUP BY AccountId]){
             accntLst.add(new Account(Id = (Id)aResult.get('Id'),Number_Of_Contacts__c = (Integer) aResult.get('cnt'))); 
        }
    }
}