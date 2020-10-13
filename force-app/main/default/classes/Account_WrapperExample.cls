public class Account_WrapperExample {
    public List<Account_Wrapper> accounts{get;set;}

    public Account_WrapperExample(){
        accounts = new list<Account_Wrapper>();
        add();
    }
    public void add()
    {
        Account_Wrapper aw= new Account_Wrapper();
        aw.acc = new Account();
        accounts.add(aw);
    }
}