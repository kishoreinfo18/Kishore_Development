public class Checkbox_Class {
    List<WrapperClass1> accountList=new List<WrapperClass1>();
    List<Account> selectedAccount=new list<Account>();
    public List<WrapperClass1> getAccounts()
    {
     for(account a:[select name,phone from account limit 5])
         {
         accountList.add(new WrapperClass1(a));
         }
         return accountList;
    }
    public pageReference getSelected()
    {
    selectedAccount.clear();
    for(WrapperClass1 accWrapper:accountList)
      if(accWrapper.selected==true)
           selectedAccount.add(accWrapper.acc);
           return null;
    }
    public list<Account> getSelectedAccounts()
    {
        if(selectedAccount.size()>0)
        return selectedAccount;
        else
        return null;
    }
    
    public class WrapperClass1
    {
     public Account acc{get;set;}
     public boolean selected{get;set;}
         public WrapperClass1(Account a)
         {
          acc=a;
          selected=false;
         }
    } 
}