trigger CSSTrigger on CSS__c (after insert, after update) {
    if (Trigger.IsInsert) {
        System.debug('Is an Ins');
        List<CSS__c> insertedCSS = new List<CSS__c>();
        Integer year =  System.Today().year();

        for (CSS__c c : Trigger.new) {
            if (c.Data_Type__c == 'Sales Quantity (NT)') {
                List<CSS_Month__c> cssMonthsToInsert = new List<CSS_Month__c>();
                for (Integer i=1 ;i<13;i++) {
                    CSS_Month__c newMonth = new CSS_Month__c (CSS__c = c.Id, Account__c = c.Account__c, Product__c = c.Product__c);

                    if (i==1) {
                        newMonth.Month__c = 'January';
                        newMonth.Gross_Margin__c = c.Jan__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 1, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==2) {
                        newMonth.Month__c = 'February';
                        newMonth.Gross_Margin__c = c.Feb__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 2, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==3) {
                        newMonth.Month__c = 'March';
                        newMonth.Gross_Margin__c = c.Mar__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 3, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==4) {
                        newMonth.Month__c = 'April';
                        newMonth.Gross_Margin__c = c.Apr__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 4, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==5) {
                        newMonth.Month__c = 'May';
                        newMonth.Gross_Margin__c = c.May__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 5, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==6) {
                        newMonth.Month__c = 'June';
                        newMonth.Gross_Margin__c = c.Jun__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 6, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==7) {
                        newMonth.Month__c = 'July';
                        newMonth.Gross_Margin__c = c.Jul__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 7, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==8) {
                        newMonth.Month__c = 'August';
                        newMonth.Gross_Margin__c = c.Aug__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 8, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==9) {
                        newMonth.Month__c = 'September';
                        newMonth.Gross_Margin__c = c.Sep__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 9, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==10) {
                        newMonth.Month__c = 'October';
                        newMonth.Gross_Margin__c = c.Oct__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 10, 1);

                    }                    
                    if (i==11) {
                        newMonth.Month__c = 'November';
                        newMonth.Gross_Margin__c = c.Nov__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 11, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==12) {
                        newMonth.Month__c = 'December';
                        newMonth.Gross_Margin__c = c.Dec__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 12, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                }
                insert cssMonthsToInsert;

            }
            if (c.Data_Type__c == 'Sales Quantity (Units)') {
                
                for (Integer i=1 ;i<13;i++) {
                    List<CSS_Month__c> cssMonthsToInsert = new List<CSS_Month__c>();
                    CSS_Month__c newMonth = new CSS_Month__c (CSS__c = c.Id, Account__c = c.Account__c, Product__c = c.Product__c);
                    if (i==1) {
                        newMonth.Month__c = 'January';
                        newMonth.Sales_Quantity_Units__c = c.Jan__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 1, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==2) {
                        newMonth.Month__c = 'February';
                        newMonth.Sales_Quantity_Units__c = c.Feb__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 2, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==3) {
                        newMonth.Month__c = 'March';
                        newMonth.Sales_Quantity_Units__c = c.Mar__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 3, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==4) {
                        newMonth.Month__c = 'April';
                        newMonth.Sales_Quantity_Units__c = c.Apr__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 4, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==5) {
                        newMonth.Month__c = 'May';
                        newMonth.Sales_Quantity_Units__c = c.May__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 5, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==6) {
                        newMonth.Month__c = 'June';
                        newMonth.Sales_Quantity_Units__c = c.Jun__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 6, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==7) {
                        newMonth.Month__c = 'July';
                        newMonth.Sales_Quantity_Units__c = c.Jul__c;
                        newMonth.Month_Date__c =Date.newInstance(2021, 7, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==8) {
                        newMonth.Month__c = 'August';
                        newMonth.Sales_Quantity_Units__c = c.Aug__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 8, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==9) {
                        newMonth.Month__c = 'September';
                        newMonth.Sales_Quantity_Units__c = c.Sep__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 9, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==10) {
                        newMonth.Month__c = 'October';
                        newMonth.Sales_Quantity_Units__c = c.Oct__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 10, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==11) {
                        newMonth.Month__c = 'November';
                        newMonth.Sales_Quantity_Units__c = c.Nov__c;
                        newMonth.Month_Date__c =Date.newInstance(2021, 11, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==12) {
                        newMonth.Month__c = 'December';
                        newMonth.Sales_Quantity_Units__c = c.Dec__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 12, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                }
            }
            if (c.Data_Type__c == 'Sales Value ($)') {
                List<CSS_Month__c> cssMonthsToInsert = new List<CSS_Month__c>();
                for (Integer i=1 ;i<13;i++) {
                    CSS_Month__c newMonth = new CSS_Month__c (CSS__c = c.Id, Account__c = c.Account__c, Product__c = c.Product__c);
                    if (i==1) {
                        newMonth.Month__c = 'January';
                        newMonth.Sales_Value__c = c.Jan__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 1, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==2) {
                        newMonth.Month__c = 'February';
                        newMonth.Sales_Value__c = c.Feb__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 2, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==3) {
                        newMonth.Month__c = 'March';
                        newMonth.Sales_Value__c = c.Mar__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 3, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==4) {
                        newMonth.Month__c = 'April';
                        newMonth.Sales_Value__c = c.Apr__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 4, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==5) {
                        newMonth.Month__c = 'May';
                        newMonth.Sales_Value__c = c.May__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 5, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==6) {
                        newMonth.Month__c = 'June';
                        newMonth.Sales_Value__c = c.Jun__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 6, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==7) {
                        newMonth.Month__c = 'July';
                        newMonth.Sales_Value__c = c.Jul__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 7, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==8) {
                        newMonth.Month__c = 'August';
                        newMonth.Sales_Value__c = c.Aug__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 8, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==9) {
                        newMonth.Month__c = 'September';
                        newMonth.Sales_Value__c = c.Sep__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 9, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==10) {
                        newMonth.Month__c = 'October';
                        newMonth.Sales_Value__c = c.Oct__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 10, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==11) {
                        newMonth.Month__c = 'November';
                        newMonth.Sales_Value__c = c.Nov__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 11, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==12) {
                        newMonth.Month__c = 'December';
                        newMonth.Sales_Value__c = c.Dec__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 12, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                }
            }
            if (c.Data_Type__c == 'Gross Margin ($)') {
                List<CSS_Month__c> cssMonthsToInsert = new List<CSS_Month__c>();
                for (Integer i=1 ;i<13;i++) {
                    CSS_Month__c newMonth = new CSS_Month__c (CSS__c = c.Id, Account__c = c.Account__c, Product__c = c.Product__c);
                    if (i==1) {
                        newMonth.Month__c = 'January';
                        newMonth.Sales_Quantity_NT__c = c.Jan__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 1, 1);
                        cssMonthsToInsert.add(newMonth);
                        
                    }                    
                    if (i==2) {
                        newMonth.Month__c = 'February';
                        newMonth.Sales_Quantity_NT__c = c.Feb__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 2, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==3) {
                        newMonth.Month__c = 'March';
                        newMonth.Sales_Quantity_NT__c = c.Mar__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 3, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==4) {
                        newMonth.Month__c = 'April';
                        newMonth.Sales_Quantity_NT__c = c.Apr__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 4, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==5) {
                        newMonth.Month__c = 'May';
                        newMonth.Sales_Quantity_NT__c = c.May__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 5, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==6) {
                        newMonth.Month__c = 'June';
                        newMonth.Sales_Quantity_NT__c = c.Jun__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 6, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==7) {
                        newMonth.Month__c = 'July';
                        newMonth.Sales_Quantity_NT__c = c.Jul__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 7, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==8) {
                        newMonth.Month__c = 'August';
                        newMonth.Sales_Quantity_NT__c = c.Aug__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 8, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==9) {
                        newMonth.Month__c = 'September';
                        newMonth.Sales_Quantity_NT__c = c.Sep__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 9, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==10) {
                        newMonth.Month__c = 'October';
                        newMonth.Sales_Quantity_NT__c = c.Oct__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 10, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==11) {
                        newMonth.Month__c = 'November';
                        newMonth.Sales_Quantity_NT__c = c.Nov__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 11, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                    if (i==12) {
                        newMonth.Month__c = 'December';
                        newMonth.Sales_Quantity_NT__c = c.Dec__c;
                        newMonth.Month_Date__c = Date.newInstance(2021, 12, 1);
                        cssMonthsToInsert.add(newMonth);
                    }                    
                }
            }
        }
        
      
    }else if (Trigger.IsUpdate) {
        System.debug('Is an Update');
        // Map<Id, CSS__c> cssRecords = new Map<Id, CSS__c>();
        // for (Integer i=0 ; i<Trigger.new.size();i++) {
        //     cssRecords.put(Trigger.new[i].Id, Trigger.new[i]);
        // }
        // if (cssRecords.size() > 0) {
        //     Database.executeBatch(new UpdateCSSMonthsBatch(cssRecords));
        // }
        
        List<CSS_Month__c> cssToUpdate = new List<CSS_Month__c>();
        for (CSS__c c : Trigger.new ) {
            for (CSS_Month__c month : [SELECT Id, Month__c, Sales_Quantity_NT__c, Sales_Quantity_Units__c, Sales_Value__c,Gross_Margin__c 
            FROM CSS_Month__c WHERE CSS__c =  :c.Id ]) {
                CSS_Month__c newMonth = new CSS_Month__c (CSS__c = c.Id, Account__c = c.Account__c, Product__c = c.Product__c);
                if (c.Data_Type__c == 'Sales Quantity (NT)') {                    
                    if (month.Month__c == 'January') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.Jan__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'February') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.Feb__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'March') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.Mar__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'April') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.Apr__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'May') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.May__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'June') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.Jun__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'July') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.Jul__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'August') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.Aug__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'September') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.Sep__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'October') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.Oct__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'November') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.Nov__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'December') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Quantity_NT__c = c.Dec__c;
                        cssToUpdate.add(newMonth);
                    }
                }    
                if (c.Data_Type__c == 'Sales Quantity (Units)') {
                    if (month.Month__c == 'January') {
                        newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.Jan__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'February') {
                        newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.Feb__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'March') {
                        newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.Mar__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'April') {
                        newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.Apr__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'May') {
                        newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.May__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'June') {
                        newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.Jun__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'July') {
                        newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.Jul__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'August') {
                        newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.Aug__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'September') {
                        newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.Sep__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'October') {
                                                newMonth.Id = month.Id;newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.Oct__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'November') {
                        newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.Nov__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'December') {
                        newMonth.Id = month.Id;                        
                        newMonth.Sales_Quantity_Units__c = c.Dec__c;
                        cssToUpdate.add(newMonth);
                    }
                }
                if (c.Data_Type__c == 'Sales Value ($)') {
                    if (month.Month__c == 'January') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.Jan__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'February') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.Feb__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'March') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.Mar__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'April') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.Apr__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'May') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.May__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'June') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.Jun__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'July') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.Jul__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'August') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.Aug__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'September') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.Sep__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'October') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.Oct__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'November') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.Nov__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'December') {
                        newMonth.Id = month.Id;
                        newMonth.Sales_Value__c = c.Dec__c;
                        cssToUpdate.add(newMonth);
                    }
                }
                if (c.Data_Type__c == 'Gross Margin ($)') {
                    if (month.Month__c == 'January') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.Jan__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'February') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.Feb__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'March') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.Mar__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'April') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.Apr__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'May') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.May__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'June') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.Jun__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'July') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.Jul__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'August') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.Aug__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'September') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.Sep__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'October') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.Oct__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'November') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.Nov__c;
                        cssToUpdate.add(newMonth);
                    }
                    if (month.Month__c == 'December') {
                        newMonth.Id = month.Id;
                        newMonth.Gross_Margin__c = c.Dec__c;
                        cssToUpdate.add(newMonth);
                    }
                }
            } 
        }
        Update cssToUpdate;               
    } 
}