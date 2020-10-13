public class cls_SOQL_Relations {
    public list<Account> lstAss{get;set;}
    public void stndardRelation(){
        lstAss=[select name,industry,(select firstName,lastName from contacts) from account];
       
    }
}