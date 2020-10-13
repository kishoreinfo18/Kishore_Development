trigger ClassTrigger on Case (before insert,before update) {
for (Case c:trigger.New){
if(c.Reason=='Feedback')
   c.Priority='Low';
}
}