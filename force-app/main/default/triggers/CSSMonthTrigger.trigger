trigger CSSMonthTrigger on CSS_Month__c (after insert, after update) {
    List<CSS_Month__c> monthsToUpdate = new List<CSS_Month__c>();
    List<Budget_Month__c> budgetsToInsert = new List<Budget_Month__c>();
    Map<Id, Budget_Month__c> budgetsToMonthMap = new Map<Id, Budget_Month__c>();
    Set<Id> accSet = new Set<Id>();
    Set<Id> prodSet = new Set<Id>();
    Set<Date> dateSet = new Set<Date>();
    Set<Id> accountIds = new Set<Id>();
    Set<Id> productIds = new Set<Id>();
    List<Date> dateList = new List<Date>();
    for (Integer i=0;i<Trigger.new.size();i++) {
        if (Trigger.new[i].Product__c != null && Trigger.new[i].Account__c != null) {
            // budgetList.add(Trigger.new[i]);
            accountIds.add(Trigger.new[i].Account__c);
            productIds.add(Trigger.new[i].Product__c);
            dateList.add(Trigger.new[i].Month_Date__c);
        }
    }
    
    for (Budget_Month__c budMonth : [SELECT Id, Date__c, Product__c, Account__c, Automatically_created__c, No_of_Units_Sold_Tonne_Pound__c, Sales_Revenue__c, Gross_Margin__c
        FROM Budget_Month__c WHERE Account__c = :accountIds AND Product__c = :productIds AND Date__c = :dateList]){
            budgetsToMonthMap.put(budMonth.Id, budMonth);
        }
        // for (Budget_Month__c b : budMonth) {
        //     accSet.add(b.Account__c);
        //     prodSet.add(b.Product__c);
        //     dateSet.add(b.Date__c);
        // }
        // for (CSS_Month__c record : Trigger.new) {
        //     for (Budget_Month__c budget : budMonth) {
        //         if (accSet.contains(record.Account__c)&&prodSet.contains(record.Product__c)&&dateSet.contains(record.Month_Date__c)) {
        //             record.Budget_Month__c = budget.Id;
        //             monthsToUpdate.add(record);
        //         }else {
        //             Budget_Month__c newBudMonth = new Budget_Month__c ();
        //             newBudMonth.Date__c = record.Month_Date__c;
        //             newBudMonth.Product__c = record.Product__c;
        //             newBudMonth.Account__c = record.Account__c;
        //             newBudMonth.Automatically_created__c = true;
        //             newBudMonth.No_of_Units_Sold_Tonne_Pound__c = 0;
        //             newBudMonth.Sales_Revenue__c = 0;
        //             newBudMonth.Gross_Margin__c = 0;

        //             budgetsToInsert.add(newBudMonth);
        //             record.Budget_Month__c = budget.Id;
        //             monthsToUpdate.add(record);
        //         }
        //     }
        // }    
            
    insert budgetsToInsert;
    update monthsToUpdate;
    
}