public class Interest_Calculator
{
    public Decimal Amount{get;set;}
    public Decimal Year{get;set;}
    public Decimal rate{get;set;}
    public Decimal interest{get;set;}
    public void Calculate()
    {
        if(Amount>0)
        {

            Interest=(Amount*rate*year)/100;
                    }
        else
        {
        apexPages.Message msg1 = new apexPages.Message(apexPages.Severity.Error,'there is Amount is mandatory in error');
            apexpages.addMessage(msg1);

        }
    } 
    public void Reset()
    {
     Amount=null;
     year=null;
     rate=null;
     interest=null;     
    }
}