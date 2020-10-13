public class WrapClassOnAccount{
 
 list<WraperClass> wrpclass{get;set;}
      public WrapClassOnAccount()
      {
       wrpclass=new list<WraperClass>();
       for(account a:[select id,name,phone from account limit 10])
       {
            wrpclass.add(new WraperClass(a));
       } 
      }
   public class WraperClass
    {
     public account acc{get;set;}
     public boolean isSelected{get;set;}
     public WraperClass(Account acnt)
     {
     acc=acnt;
     isSelected=false;
     }
    }
}