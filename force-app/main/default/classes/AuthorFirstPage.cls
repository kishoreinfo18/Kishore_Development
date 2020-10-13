public class AuthorFirstPage{
    public string aName{get; set;}
    public AuthorFirstPage(){
        system.debug('Authot Name is :');
        aName='Kishore Kumar Reddy Y';
    }
    public void setName(String paname){
        aName=paName;
    }
    public String getName(){
        return aName;
    }
}