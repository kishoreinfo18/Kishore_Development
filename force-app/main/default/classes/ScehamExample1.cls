public class ScehamExample1 {
    public map<String,object> objDetails  {get;set;}
	public ScehamExample1(){
        Schema.DescribeSObjectResult res = Product2.sobjecttype.getdescribe();
        objDetails.put('Label', res.getLabel());
        objDetails.put('Name', res.getName());
    }
}