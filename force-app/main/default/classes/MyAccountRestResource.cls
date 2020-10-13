@RestResource(urlMapping='/Contact/*')
global with sharing class MyAccountRestResource {
    @HttpPost
    global static String doPost(String lName) {
        Contact cont = new Contact();
        cont.LastName = lName;
        insert cont;
        return cont.Id;
    }
}