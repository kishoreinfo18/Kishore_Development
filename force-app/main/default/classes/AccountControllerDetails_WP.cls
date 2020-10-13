public class AccountControllerDetails_WP {
    public list<AccountControllerDetail_Wrapper>  students   {get;set;}
    public list<string> fname {set;get;}
    public AccountControllerDetails_WP(){
        students = new List<AccountControllerDetail_Wrapper>();
        fname = new List<string>();
        AccountControllerDetail_Wrapper st = new AccountControllerDetail_Wrapper();
        st.first_name='kishore';
        st.last_name='kumar';
        st.city='hyd';
        st.phone='343343';
        AccountControllerDetail_Wrapper st1 = new AccountControllerDetail_Wrapper();
        st1.first_name='Ravi';
        st1.last_name='kumar';
        st1.city='BLR';
        st1.phone='8764787';
        AccountControllerDetail_Wrapper st2 = new AccountControllerDetail_Wrapper();
        st2.first_name='Sruthi';
        st2.last_name='yalluri';
        st2.city='London';
        st2.phone='075415310606';
        students.add(st);
        students.add(st1);
        students.add(st2);
        fname.add(st.first_name);
        fname.add(st1.first_name);
        fname.add(st2.first_name);
    }
}