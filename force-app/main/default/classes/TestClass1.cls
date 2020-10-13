public class TestClass1 {
    TestClass1(){
    string strPhone='888#4278787';
     String specialChars = '&|^|@|*|#|%|!|$|(|)|-'; 
     for(string s : specialChars.split('|')){
       strPhone = strphone.remove(s).replaceAll( '\\s+', '');
        System.debug(strPhone);
    }
  }	
}