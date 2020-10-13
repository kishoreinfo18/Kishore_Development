@isTest
public class TestVerifyDate{
    @isTest
    public static void CheckDatesTest(){
        Date startDate = Date.newInstance(2020, 04, 12);
        Date endDate = Date.newInstance(2020, 05, 12);
        Date CheckDates = VerifyDate.CheckDates(startDate,endDate);
        System.assertNotEquals(endDate,CheckDates);
        
        Date startDate1 = Date.newInstance(2020, 04, 12);
        Date endDate1 = Date.newInstance(2020, 05, 10);
        Date CheckDates1 = VerifyDate.CheckDates(startDate1,endDate1);
        
    } 
    
}