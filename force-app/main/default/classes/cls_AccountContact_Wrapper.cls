public class cls_AccountContact_Wrapper {
    public class WrapperClass{
        @AuraEnabled Account accnt {get;set;}
        @AuraEnabled List<contact> lstCont {get;set;}
    }
    public static WrapperClass getAccntContDetails(){
      WrapperClass wrp = new WrapperClass();
        wrp.accnt = [select name,phone from account];
        wrp.lstCont = [select firstName,Lastname,MailingAddress,email from contact];
        return wrp;
    }
}