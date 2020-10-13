public class apexPagesMessage{
    public apexPagesMessage()
    {
        apexPages.message msg1 = new apexPages.message(apexPages.Severity.Error,'there is account in error');
        apexPages.message msg2 = new apexPages.message(apexPages.Severity.Warning,'this is Warning');
        apexpages.addMessage(msg1);
        apexpages.addMessage(msg2);
    }
}