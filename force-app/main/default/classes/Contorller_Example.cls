public class Contorller_Example {
    public List<Account> accounts{get;set;}
    public Account acc{get;set;}
    public Contorller_Example()
    {
        acc = new Account();
        accounts = new List<Account>();
    }
    public void add()
    {
        accounts.add(acc);
        acc = new Account();
    }
    public void remove(){
        accounts.clear();
    }

}