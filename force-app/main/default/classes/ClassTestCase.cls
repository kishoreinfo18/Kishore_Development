@isTest
private class ClassTestCase{
static testmethod void caseMethod(){
User u = [Select Id,Name,Alias from User where Name='Kishore Reddy' and Alias='kredd'];
system.RunAs(u){
    Case cs=new Case();
    cs.Status='New';
    cs.Origin='Email';
    insert cs;
    }
  }
}