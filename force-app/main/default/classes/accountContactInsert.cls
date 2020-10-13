public with sharing class accountContactInsert {
Public String AccName{get;set;}
public String accPhone{get;set;}
    public pageReference InsertAcccon()
    {
     Account acc=new Account();
     acc.Name=accName;
     acc.Phone=accphone;
     insert acc;
     Pagereference ref = New Pagereference ('/apex/vf_AccountContactData');
        ref.setredirect(true);
        return ref;
    }
    public pageReference CancelAcccon()
    {
     PageReference cref=new pageReference('/apex/vf_AccountContactData');
     cref.setRedirect(true);
     return cref;
     }
}