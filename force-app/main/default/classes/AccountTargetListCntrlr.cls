public class AccountTargetListCntrlr {
    public String getSelectedvalue{get;set;}
    public List<SelectOption> options {get;set;}
    public integer totalTLsCount{get;set;}
      public AccountTargetListCntrlr()
    {
     getSelectedvalue='My Target lists';
     totalTLsCount=0;
     
    }
    public List<SelectOption> getTLViewList(){
     options=new List<selectOption>();
     options.add(new SelectOption('My Target Lists', 'My Target Lists'));
     options.add(new SelectOption('Shared Target Lists', 'Shared Target Lists'));
     return options;
    }
}