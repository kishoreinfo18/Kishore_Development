public with sharing class PageBlockButtonSave {
  public account acc{get;set;}
  public String name{get;set;}
  public string phone{get;set;}
  public string StringValue{get;set;}
  public PageBlockButtonSave ()
 {
  acc=new account();
  acc.name=name;
  acc.phone=phone;
  StringValue=acc.name+'   '+acc.phone;
 }
 public pageReference actionSaveContact()
 {
 insert acc;
 Pagereference ref = New Pagereference ('/'+acc.Id);
 return ref;
 }

}