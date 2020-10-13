trigger trg_ChkDuplicateEamilLead on Lead (before insert) {
   if(trigger.IsInsert)
   {
  LeadHandler.ChkDuplicateEmail(trigger.new);
   }
 }