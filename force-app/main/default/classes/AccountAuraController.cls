public class AccountAuraController {
    @AuraEnabled
    public static List<String> getIndustry(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = contact.Salutation.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.add(p.getLabel());
        }
        return options;
    }
    @AuraEnabled
    public static Account getAccDetails(){
        Account acc = new Account();
        acc=[select id,name,phone from account where industry =:'Agriculture'];
        return acc;
    }
}