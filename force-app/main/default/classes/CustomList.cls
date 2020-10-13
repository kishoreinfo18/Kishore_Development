public class CustomList{
    public List<Foundation_Country__c> cntrData{get;set;}
    public CustomList()
    {
        Map<String,Foundation_Country__c> cntr=Foundation_Country__c.getAll();
        cntrData=cntr.values();
        system.debug('custom setting values are :' + cntr);
    }
}