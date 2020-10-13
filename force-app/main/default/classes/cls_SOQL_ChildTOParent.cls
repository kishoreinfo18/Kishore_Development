public class cls_SOQL_ChildTOParent {
    public List<contact> con {get;set;}
    public boolean flg1 {get;set;}
    public boolean flg2 {get;set;}
    public void stndrdrelation(){
        flg1=true;
        flg2=false;
        con=[select firstName,LastName,Account.name,Account.industry from contact];
    }
    public void customrelation(){
        flg1=false;
        flg2=true;
        con=[select firstName,LastName,AccountName__r.name,AccountName__r.industry from contact where AccountName__r.name!=null];
    }

}