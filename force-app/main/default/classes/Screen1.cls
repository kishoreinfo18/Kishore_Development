public class Screen1 {
public Account account{get;set;}
 public screen1()
 {
   account=new account();
 }
 public pageReference save()
 {
  insert account;
  pageReference pr=new pageReference('/apex//screen2?id='+account.id);
  return pr;
 }
}