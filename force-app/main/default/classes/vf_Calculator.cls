public class vf_Calculator {
    public Integer aval{get;set;}
    public Integer bval{get;set;}
    public Integer result{get;set;}
    public void addMethod()
    {
        result=aval+bval;
    }
    public void subMethod()
    {
       result=aval-bval;
    }
    public integer multiMethod()
    {
    return result=aval*bval;
    }
    public void resetMethod()
    {
    aval=0;
    bval=0;
    }
}