@isTest
public class TestRestrictContactByName{
    @isTest
    public static void RestrictContactByNameTst(){
        Contact cont = new Contact(LastName = 'INVALIDNAME');
        Contact contUpd = new Contact(Id=cont.Id,LastName = 'INVALIDNAME1');
        insert contUpd;
        Contact contUpd1 = new Contact(Id=contUpd.Id,LastName = 'INVALIDNAME1');
        Test.startTest();
        Database.SaveResult result = database.insert(cont,false);
        Database.SaveResult result1 = database.update(contUpd1,false);
        Test.stopTest();
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',
                             result.getErrors()[0].getMessage());

    }
}