@istest
public class LeadProcessorTest {
	@testSetup 
    static void setup() {
        List<lead> leadLst = new List<Lead>();
        for(Integer i=0;i<10;i++){
        	Lead ld = new Lead();
            ld.LastName='testlead'+i;
            ld.Company='test';
            leadLst.add(ld);
        }
        insert leadLst;
    }
    static testMethod void LeadProcessorTst(){
    	Test.startTest();
        LeadProcessor ldp = new LeadProcessor();
         Id batchId = Database.executeBatch(ldp);
        test.stopTest();
    }
}