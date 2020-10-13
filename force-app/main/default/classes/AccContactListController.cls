public class AccContactListController {
    @AuraEnabled
    public static list<Contact> getContactList()
    {
        List<Contact> lstCont = [select firstname,lastname,email,phone from contact limit 10] ;
        return lstCont;
	}

}