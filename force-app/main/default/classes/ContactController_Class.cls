public class ContactController_Class {
    public list<Contact> getContact()
    {
     	list<Contact> lstCon;
            lstcon=[select id,name,email,phone from contact];
        
        return lstcon;
    }

}