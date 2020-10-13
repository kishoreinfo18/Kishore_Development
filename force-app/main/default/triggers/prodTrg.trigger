trigger prodTrg on Product2 (before insert) 
{
    if(trigger.isInsert || trigger.isUpdate)
    {
        ProductHandler.prodDuplicateChk(trigger.new);
    }
}