public class ContactWrapper_Details {
    public List<Contact_Wrapper> wcontwr {get;set;}
    Contact_Wrapper cw {get;set;}
        public ContactWrapper_Details(){
            wcontwr = new List<Contact_Wrapper>();
            cw = new Contact_Wrapper();
            cw.cont = new Contact();
            cw.cont.Phone='123456789';
            cw.flag=true;
            wcontwr.add(cw);
            cw = new Contact_Wrapper();
            cw.cont = new Contact();
            cw.cont.Phone='987654321';
            cw.flag=false;
            wcontwr.add(cw);
        }
}