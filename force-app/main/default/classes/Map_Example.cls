public class Map_Example {
    map<string,list<string>> mp {get;set;}
    list<SelectOption> obj 		{get;set;}
    list<SelectOption> fields 		{get;set;}
    public Map_Example(){
        mp = new map<string,list<string>> ();
        obj = new list<SelectOption>();
        fields = new list<SelectOption>();
        SelectOption n = new SelectOption('none','-none-');
        obj.add(n);
        fields.add(n);
        
    }
}