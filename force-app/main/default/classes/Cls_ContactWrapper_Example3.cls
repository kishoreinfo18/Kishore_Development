public class Cls_ContactWrapper_Example3 {
	public class Cls_Wrapper_Example2
    {
        @AuraEnabled public Contact cont {get;set;}
        @AuraEnabled public Integer cnt{get;set;}
        public Cls_Wrapper_Example2(Contact cont, Integer cnt)
        {
            this.cont=cont;
            this.cnt=cnt;
        }
     }
    @AuraEnabled
    public static list<string> getIndustry()
    {
    	List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.add(p.getLabel());
        }
        return options;
    }
    @AuraEnabled
    public static list<Cls_Wrapper_Example2> getContactDetails(){
        Integer counter=0;
        Cls_Wrapper_Example2 wrp;
        List<Cls_Wrapper_Example2> lstWrp = new List<Cls_Wrapper_Example2>();
        List<contact> lstCont = [select name,phone,title,Email from contact];
        for(Contact cont:lstCont){
            counter = counter+1;
            wrp = new Cls_Wrapper_Example2(cont,counter);
            lstWrp.add(wrp);
        }
        return lstWrp;
    }
}