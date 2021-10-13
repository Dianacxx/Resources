public class ScheduledClass implements Schedulable {
    public void execute(SchedulableContext sc) 
    {
        PelotonIntegrationAPI.getPelotonAging();
        PelotonIntegrationAPI.getPelotonOrder();
        PelotonIntegrationAPI.getPelotonInvoice();
        // PelotonIntegrationAPI.getPelotonCSS();
        


    }
}
