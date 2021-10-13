public class ScheduledCSSClass implements Schedulable {
        public void execute(SchedulableContext sc) 
        {
            PelotonIntegrationAPI.getPelotonCSS('Sales Value ($)');
            PelotonIntegrationAPI.getPelotonCSS('Sales Quantity (NT)');
            PelotonIntegrationAPI.getPelotonCSS('Gross Margin ($)');
            PelotonIntegrationAPI.getPelotonCSS('Sales Quantity (Units)');
        }
}
