public class ProductHandler
{
  /*  public static void prodDuplicateChk(List<Product2> lstprod)
    {
        set<String> prodName = new set<String>();
        for(Product2 prod:lstProd)
        {
            prodname.add(prod.name);
        }
        List<Product2> prodlst = [select name from Product2 where name in : prodname];
        system.debug('product details are :' + prodname);
        system.debug('product in list are :' + prodlst);
        if(!prodlst.isEmpty()) 
        {
        system.debug('same product exists');
        }
    } */
    
  public static void prodDuplicateChk(List<Product2> lstprod)
  {
      map<String,String> mapPrdName =  new map<String,String>();
      for(Product2 prd: lstprod)
      {
          mapPrdName.Put(prd.ProductCode,prd.Name);
      }
      system.debug('map product values are '+mapprdName);
  
     for(Product2 prod:lstprod)
      {
      system.debug('duplicate values are :'+ prod.name);
      system.debug('mapping product details are :'+mapPrdName.get(prod.ProductCode));
        if(prod.name==mapPrdName.get(prod.ProductCode))
        {
        prod.addError('you have entered duplicates');
        }
      }
    } 
       
}