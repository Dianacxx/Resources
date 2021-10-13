global with sharing class PelotonIntegrationAPI {
    @future(callout=true) //Sets the callout as an asynchronous operation
    global static void getPelotonAging() {
        //Creation of the variables I am going to use to send the HTTP Request
        String endpoint = 'https://TestOICic-aiocmiller.integration.ocp.oraclecloud.com:443/ic/api/integration';
        String resource = '/v1/flows/rest/QUERY_AGING_SALES_REPORT/1.0/aging/query';
        String queryParams = '?trxType=Receipt';
        String username = 'SFDC_Integration';
        String password = 'M1ll3r@$fdc123';
        String method = 'GET';  
        MAP<Id,Aging__c> aginToUpsMap = new MAP<Id,Aging__c>();
        List<Aging__c> newAgingList = new List<Aging__c>();

        //Creating the request and setting the required resources
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http h = new Http();

        req.setEndpoint(endpoint+resource);
        req.setMethod(method);
        req.setTimeout(120000);
        //Oracle is using a basic authorization, that consist of a username:password 
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String autorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);

        req.setHeader('Authorization', autorizationHeader);

        res = h.send(req);
        System.debug('Size: '+ Limits.getHeapSize() + 'Limit: '+Limits.getLimitHeapSize());
        System.debug('This is the status code ' + res.getStatusCode());
        //If the status code of the response is 200 or 201, the method can start working with the data retrieved in the body of the response
        if ( (res.getStatusCode() == 200 || res.getStatusCode()== 201) && res.getBody() !=null) {
            //Deserializing the json body and putting it inside of a Salesforce Object
            Map<String,Object> untypedMap = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            //From the body we only need a sub-list called 'records', so we are singlingg them out in this list
            List<Object> resultsList = (List<Object>) untypedMap.get('records');   
            //List of records to upsert                 
            List<Aging__c> agingToUps = new List<Aging__c>(); 
            //We use this to stablish the field that salesforce will be using to pair the records instead of the salesforce generated Id. In this case its the external Id.
            Schema.SObjectField c = Aging__c.Fields.External_Key__c;
            for (Object d : resultsList) {
                //We are inserting all of the records from the deserialized list inside a map, this way we can search the data with the key
                Map<string, Object> agingMap = (Map<string, Object>)d;
                //The Aging is parented by an account, so we have to look for the parent inside salesforce using the external key.
                Account parentAcc = new Account (Oracle_Account_Number__c =(String)agingMap.get('accountNumber'));
                //We create a new instance of the Aging, using the external Id and parenting it with the salesforce account
                Aging__c newAging = new Aging__c(External_Key__c = (String)agingMap.get('trxNumber'),
                                                 Customer__r=parentAcc);
                newAging.Balance_Overdue__c = (Decimal)agingMap.get('balanceOverdue');
                newAging.Between_01_30__c = (Decimal)agingMap.get('dd1To30');
                newAging.Between_31_60__c = (Decimal)agingMap.get('dd31To30');
                newAging.Between_61_90__c = (Decimal)agingMap.get('dd61To30');
                newAging.Over_90__c = (Decimal)agingMap.get('ddOver90');
                newAging.Current__c = (Decimal)agingMap.get('current');
                newAging.Due_Date__c = Date.valueOf((String) agingMap.get('dueDate') );
                newAging.Invoice_Date__c = Date.valueOf((String)agingMap.get('invoiceDate'));
                newAging.TOTAL_AMT_REM__c = (Decimal)agingMap.get('total');
                newAging.TRX_Type__c = (String)agingMap.get('trxType');
                newAging.Name = (String)agingMap.get('businessUnitName');
                newAging.Invoice_Receipt_Number__c = (String)agingMap.get('trxNumber');
                //We are excluding the record parented by the accounts 4011, since it doesn't exist in salesforce.
                if (String.valueOf(agingMap.get('accountNumber')) != '4011' ) {

                    agingToUps.add(newAging);
                }
                
            }

            System.debug('upserted Aging: ' + agingToUps.size() + ' - ' + agingToUps);
            //This way of userting, takes the aging list and the field used to pair them inside salesforce
			Database.UpsertResult[] cr = Database.upsert(agingToUps, c);
        }
    }
    @future(callout=true)
    global static void getPelotonOrder() {
        Date dToday = System.Today();
        String todayYear = String.valueOf(dToday.year());
        String todayMonth = String.valueOf(dToday.month());
        String todayDay = String.valueOf(dToday.day());
        if(todayMonth.length()==1){
            todayMonth = '0'+todayMonth;
        }
        if(todayDay.length()==1){
            todayDay = '0'+todayDay;
        }
        String endpoint = 'https://TestOICic-aiocmiller.integration.ocp.oraclecloud.com:443/ic/api/integration';
        String resource = '/v1/flows/rest/QUERY_ORDER___SALES_REPOR/1.0/order/query';
        String lowerLimitParams = '?orderUpdateDateIsBigger='+todayYear+'-'+todayMonth+'-01';
        String higherLimitParams = '&orderUpdateDateIsLower='+todayYear+'-'+todayMonth+'-'+todayDay;
        // String lowerLimitParams = '?orderUpdateDateIsBigger=2021-10-01';
        // String higherLimitParams = '&orderUpdateDateIsLower=2021-10-04'; //yyy/mm/dd
        System.debug('dates'+ lowerLimitParams + '-'+higherLimitParams);
        String username = 'SFDC_Integration';
        String password = 'M1ll3r@$fdc123';
        String method = 'GET';  

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        // RestResponse resTo = RestContext.response;
        //resTo.headers.put('Content-Type', 'application/json');
        Http h = new Http();
       
        req.setEndpoint(endpoint+resource+lowerLimitParams+higherLimitParams);
        req.setMethod(method);
        req.setTimeout(120000);

        Blob headerValue = Blob.valueOf(username + ':' + password);
        String autorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);

        req.setHeader('Authorization', autorizationHeader);
        System.debug('Size: '+ Limits.getHeapSize() + 'Limit: '+Limits.getLimitHeapSize());
        res = h.send(req); //Error here
        
        
        System.debug('This is the status code ' + res.getStatusCode());
        if ( (res.getStatusCode() == 200 || res.getStatusCode()== 201)) {
                    
            // untypedList.add(JSON.deserializeUntyped(res.getBody()));
            Map<String,Object> untypedMap = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
  
            if(untypedMap.get('records') != null){
                List<Object> resultsList = (List<Object>) untypedMap.get('records');  
                System.debug('Size: '+resultsList.size() +'Data: ' + resultsList);
                List<Open_Order__c> orderToUps = new List<Open_Order__c>(); 
                Schema.SObjectField c = Open_Order__c.Fields.External_Key__c;
                for (Object d : resultsList) {     
                    System.debug('This are the orders: ' + d);
                    Map<String, Object> orderMap = (Map<String, Object>)d;
                    String prodId =(String)orderMap.get('item');
                    String shipDate = (String)orderMap.get('requiredShipDate');
                    // if (parentAcc) {
                        
                    // }
                    Account parentAcc = new Account(Oracle_Account_Number__c = String.valueOf(orderMap.get('customerNumber')));
                    Product2 parentProd = new Product2(External_Id__c =prodId.substring(0,6));
                    Open_Order__c newOrder = new Open_Order__c(External_key__c = (String)orderMap.get('orderNumber')+'-'+(Integer)orderMap.get('orderLineNumber')+'-'+(Integer)orderMap.get('fulfillLineNumber'),
                        Account__r = parentAcc, Product__r= parentProd);
                    System.debug('Orders with External ID' + newOrder.External_key__c);
                    newOrder.Address__c = (String)orderMap.get('address');
                    newOrder.Area_Sales_Manager__c = (String)orderMap.get('areaSalesManager');
                    newOrder.Category__c = (String)orderMap.get('category');
                    newOrder.City__c = (String)orderMap.get('city');
                    newOrder.Credit_Hold__c = (String)orderMap.get('creditHold');
                    newOrder.Customer_Item__c = (String)orderMap.get('customerItem');
                    newOrder.Customer_Name__c = (String)orderMap.get('customerName');
                    newOrder.Description__c = (String)orderMap.get('itemDescription');
                    newOrder.Extended_Sales_Amount__c = (Decimal)orderMap.get('extendedSalesAmount');
                    newOrder.F_Line_Number__c = (Integer)orderMap.get('fulfillLineNumber');
                    newOrder.Line_Number__c = (Integer)orderMap.get('orderLineNumber');
                    newOrder.Order_Number__c = (String)orderMap.get('orderNumber');
                    newOrder.Status__c = (String)orderMap.get('status');
                    newOrder.Quantity__c = (Decimal)orderMap.get('quantityOrdered');
                    newOrder.UOM__c = (String)orderMap.get('UOM');
                    newOrder.Unit_Sales_Price__c = (Decimal)orderMap.get('unitSalesPrice');
                    newOrder.Inventory_Organization__c = (String)orderMap.get('inventoryOrganization');
                    
                    if(orderMap.get('requiredShipDate')!=''){
                        newOrder.Required_Ship_Date__c = date.valueOf(shipDate.substringBefore('T'));
                    }    else{
                        system.debug('------SHIP DATE IS NULL-------');
                    }
                    
                    orderToUps.add(newOrder);     
                }
                System.debug('upserted Aging: ' + orderToUps.size() + ' - ' + orderToUps);
                Database.UpsertResult[] cr = Database.upsert(orderToUps, c);
            }else {
                System.debug('There are no records in this dates');
            }
            
        }           
        
        
        
        // Open_Order__c data = (Open_Order__c)JSON.deserialize(new Http().send(req).getBody(),Open_Order__c.class);
        
    }
    @future(callout=true)
    global static void getPelotonInvoice() {
        String outcomeMsg;
        String endpoint = 'https://TestOICic-aiocmiller.integration.ocp.oraclecloud.com:443/ic/api/integration';
        String resource = '/v1/flows/rest/QUERY_INVOI_SALES_REPOR/1.0/invoice/query';
        String queryParams = '?trxType=Receipt';
        String username = 'SFDC_Integration';
        String password = 'M1ll3r@$fdc123';
        String method = 'GET';  

        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();

        Http h = new Http();

        req.setEndpoint(endpoint+resource);
        req.setMethod(method);
        req.setTimeout(120000);

        Blob headerValue = Blob.valueOf(username + ':' + password);
        String autorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);

        req.setHeader('Authorization', autorizationHeader);

        res = h.send(req);
  
        System.debug('Size: '+ Limits.getHeapSize() + 'Limit: '+Limits.getLimitHeapSize());
        System.debug('This is the status code ' + res.getStatusCode());
        if ( (res.getStatusCode() == 200 || res.getStatusCode()== 201)) {
            Map<String,Object> untypedMap = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            List<Object> resultsList = (List<Object>) untypedMap.get('records');                    
            System.debug('Size: '+resultsList.size() +'Data: ' + resultsList);
            List<Invoice_Register__c> invoiceToUps = new List<Invoice_Register__c>(); 
            Schema.SObjectField c = Invoice_Register__c.Fields.External_Key__c;
            System.debug('Size: '+resultsList.size() +'Data: ' + resultsList);
            for (Object d : resultsList) {
                System.debug('these are the results: ' +d);
                Map<string, Object> invoiceMap = (Map<string, Object>)d;
                String prodId =(String)invoiceMap.get('productCode');
                String accId =String.valueOf(invoiceMap.get('customerNumber'));
                Account parentAcc = new Account (Oracle_Account_Number__c =accId.substringBefore('.'));
                Product2 parentProd = new Product2 (External_Id__c =prodId.substring(0,6));
                Invoice_Register__c newInvoice = new Invoice_Register__c(External_Key__c = (String)invoiceMap.get('invoiceNumber'),
                                                 Customer__r=parentAcc , Product__r=parentProd);
                newInvoice.CATEGORY_NAME__c = (String)invoiceMap.get('categoryName');
                newInvoice.CUST_ADDR__c =(String)invoiceMap.get('custAddress');
                newInvoice.CUSTOMER_NAME__c = (String)invoiceMap.get('customerName');
                newInvoice.LOT_NUMBER__c = (String)invoiceMap.get('lotNumber');
                newInvoice.PRODUCT_CODE__c =(String) invoiceMap.get('productCode');
                newInvoice.PRODUCT_DESC__c = (String)invoiceMap.get('productDescription');
                newInvoice.SALES_COORDINATOR__c = (String)invoiceMap.get('salesCoordinator');
                newInvoice.SALES_MANAGER__c = (String)invoiceMap.get('salesManager');
                newInvoice.SHIP_DATE__c = Date.valueOf((String)invoiceMap.get('shipDate'));
                newInvoice.SHIP_TO__c = (String)invoiceMap.get('shipTo');
                newInvoice.UNIT_SELLING_PRICE__c = (Decimal)invoiceMap.get('unitSellingPrice');
                newInvoice.UOM_CODE__c = (String)invoiceMap.get('Uom');
                newInvoice.WAREHOUSE_NAME__c = (String)invoiceMap.get('warehouseName');
                invoiceToUps.add(newInvoice);                
            }
            MAP<Id,Invoice_Register__c> invToUpsMap = new MAP<Id,Invoice_Register__c>();
 			invToUpsMap.putall(invoiceToUps);
            System.debug('upserted invoice: ' + invToUpsMap.values());
			Database.UpsertResult[] cr = Database.upsert(invToUpsMap.values(), c);            
        }
    }
    
    @future(callout=true)
    global static void getPelotonCSS(String type) {
        String outcomeMsg;
        String endpoint = 'https://TestOICic-aiocmiller.integration.ocp.oraclecloud.com:443/ic/api/integration';
        String resource = '/v1/flows/rest/QUERY_CSS_SALES_REPOR/1.0/css/query';
        //String queryParams = '?trxType=Receipt';
        String username = 'SFDC_Integration';
        String password = 'M1ll3r@$fdc123';
        String method = 'GET';  
        List<CSS__c> cssToUps = new List<CSS__c>(); 
        List<CSS__c> cssToUpsLimit = new List<CSS__c>(); 


        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();

        Http h = new Http();

        Schema.SObjectField c = CSS__c.Fields.External_Key__c;
        // for (Integer i=1 ;i<5;i++) {
            if (type=='Sales Quantity (NT)') {
                req.setEndpoint(endpoint+resource+'?dataType=Sales Quantity (NT)');
                req.setMethod(method);
                req.setTimeout(120000);

                Blob headerValue = Blob.valueOf(username + ':' + password);
                String autorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);

                req.setHeader('Authorization', autorizationHeader);
                System.debug('Size: '+ Limits.getHeapSize() + 'Limit: '+Limits.getLimitHeapSize());
                res = h.send(req); 
        
        
                System.debug('This is the status code ' + res.getStatusCode());
                // System.debug('This is the body Sales Quantity (NT) ' + res.getBody());
                if ( (res.getStatusCode() == 200 || res.getStatusCode()== 201)) {
                    
                   Map<String,Object> untypedMap = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                   List<Object> SalesQuantityNTList = (List<Object>) untypedMap.get('records');                    
                    System.debug('Size: '+SalesQuantityNTList.size() +'Data: ' + SalesQuantityNTList);
                    for (Object d : SalesQuantityNTList) {
                        System.debug('these are the results Sales Quantity (NT): ' +d);
                        Map<string, Object> cssMap = (Map<string, Object>)d;
                        String prodId =(String)cssMap.get('item');
                        Account parentAcc = new Account (Oracle_Account_Number__c =String.valueOf(cssMap.get('accountNumber')));
                        Product2 parentProd = new Product2 (External_Id__c =prodId.substring(0,6));
                        CSS__c newCSS = new CSS__c(External_key__c = String.valueOf(cssMap.get('accountNumber')) + '-'+String.valueOf(cssMap.get('item'))+'-'+(String)cssMap.get('dataType'),
                        Account__r=parentAcc, Product__r = parentProd);
                        System.debug('css with external IDs: ' + newCSS.External_key__c + ' acc: ' +newCSS.Account__r + ' prod: ' + newCSS.Product__r);
                        newCSS.Jan__c = (Decimal)cssMap.get('jan');
                        newCSS.Feb__c = (Decimal)cssMap.get('feb');
                        newCSS.Mar__c = (Decimal)cssMap.get('mar');
                        newCSS.Apr__c = (Decimal)cssMap.get('apr');
                        newCSS.May__c = (Decimal)cssMap.get('may');
                        newCSS.Jun__c = (Decimal)cssMap.get('jun');
                        newCSS.Jul__c = (Decimal)cssMap.get('jul');
                        newCSS.Aug__c = (Decimal)cssMap.get('aug');
                        newCSS.Sep__c = (Decimal)cssMap.get('sep');
                        newCSS.Oct__c = (Decimal)cssMap.get('oct');
                        newCSS.Nov__c = (Decimal)cssMap.get('nov');
                        newCSS.Dec__c = (Decimal)cssMap.get('dec');
                        newCSS.Data_Type__c =(String) cssMap.get('dataType');
                        newCSS.Category__c = (String)cssMap.get('category');
                        if (String.valueOf(cssMap.get('accountNumber')) != 'no ite') {
                            cssToUps.add(newCSS);
                            System.debug('real css: '+cssToUps.size());
                        }                 
                    }
                }
                // integer counter = 0;
                // while(counter<1600 && counter<cssToUps.size()) {
                //     cssToUpsLimit.add(cssToUps[counter++]);
                // }
                System.debug('upserted CSS: ' + cssToUps.size() +' - ' +cssToUps);
			    Database.UpsertResult[] cr = Database.upsert(cssToUps, c);
            }
            else if(type=='Gross Margin ($)') {
                req.setEndpoint(endpoint+resource+'?dataType=Gross Margin ($)');
                req.setMethod(method);
                req.setTimeout(120000);

                Blob headerValue = Blob.valueOf(username + ':' + password);
                String autorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);

                req.setHeader('Authorization', autorizationHeader);
                System.debug('Size: '+ Limits.getHeapSize() + 'Limit: '+Limits.getLimitHeapSize());
                res = h.send(req); 
                // System.debug('This is the body Gross Margin ($) ' + res.getBody());
                if ( (res.getStatusCode() == 200 || res.getStatusCode()== 201)) {
                    
                    Map<String,Object> untypedMap = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                    List<Object> GrossMarginMList = (List<Object>) untypedMap.get('records');                                        
                    System.debug('Size: '+GrossMarginMList.size() +'Data: ' + GrossMarginMList);
                    for (Object d : GrossMarginMList) {
                        System.debug('these are the results Gross Margin($): ' +d);
                        Map<string, Object> cssMap = (Map<string, Object>)d;
                        String prodId =(String)cssMap.get('item');
                        Account parentAcc = new Account (Oracle_Account_Number__c =String.valueOf(cssMap.get('accountNumber')));
                        Product2 parentProd = new Product2 (External_Id__c =prodId.substring(0,6));
                        CSS__c newCSS = new CSS__c(External_key__c = String.valueOf(cssMap.get('accountNumber')) + '-'+String.valueOf(cssMap.get('item'))+'-'+(String)cssMap.get('dataType'),
                        Account__r=parentAcc, Product__r = parentProd);
                        System.debug('css with external IDs: ' + newCSS.External_key__c + ' acc: ' +newCSS.Account__r + ' prod: ' + newCSS.Product__r);
                        newCSS.Jan__c = (Decimal)cssMap.get('jan');
                        newCSS.Feb__c = (Decimal)cssMap.get('feb');
                        newCSS.Mar__c = (Decimal)cssMap.get('mar');
                        newCSS.Apr__c = (Decimal)cssMap.get('apr');
                        newCSS.May__c = (Decimal)cssMap.get('may');
                        newCSS.Jun__c = (Decimal)cssMap.get('jun');
                        newCSS.Jul__c = (Decimal)cssMap.get('jul');
                        newCSS.Aug__c = (Decimal)cssMap.get('aug');
                        newCSS.Sep__c = (Decimal)cssMap.get('sep');
                        newCSS.Oct__c = (Decimal)cssMap.get('oct');
                        newCSS.Nov__c = (Decimal)cssMap.get('nov');
                        newCSS.Dec__c = (Decimal)cssMap.get('dec');
                        newCSS.Data_Type__c =(String) cssMap.get('dataType');
                        newCSS.Category__c = (String)cssMap.get('category');
                        if (String.valueOf(cssMap.get('item')) != 'no item') {
                            if (String.valueOf(cssMap.get('accountNumber')) != 'no ite') {
                                cssToUps.add(newCSS);
                                System.debug('real css: '+cssToUps.size());
                            }                            
                        }
                    }
                }
                // integer counter = 0;
                // while(counter<1600 && counter<cssToUps.size()) {
                //     cssToUpsLimit.add(cssToUps[counter++]);
                // }
                System.debug('upserted CSS: ' + cssToUps.size() +' - ' +cssToUps);
			    Database.UpsertResult[] cr = Database.upsert(cssToUps, c);
            }
            else if(type=='Sales Quantity (Units)') {
                req.setEndpoint(endpoint+resource+'?dataType=Sales Quantity (Units)');
                req.setMethod(method);
                req.setTimeout(120000);

                Blob headerValue = Blob.valueOf(username + ':' + password);
                String autorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);

                req.setHeader('Authorization', autorizationHeader);
                System.debug('Size: '+ Limits.getHeapSize() + 'Limit: '+Limits.getLimitHeapSize());
                res = h.send(req); 
                // System.debug('This is the body Sales Quantity (Units) ' + res.getBody());
                if ( (res.getStatusCode() == 200 || res.getStatusCode()== 201)) {
                    
                    Map<String,Object> untypedMap = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                    List<Object> SalesQuantityUnitsList = (List<Object>) untypedMap.get('records');                     
                    System.debug('Size: '+SalesQuantityUnitsList.size() +'Data: ' + SalesQuantityUnitsList);
                    for (Object d : SalesQuantityUnitsList) {
                        System.debug('these are the results Sales Quantity (Units): ' +d);
                        Map<string, Object> cssMap = (Map<string, Object>)d;
                        String prodId =(String)cssMap.get('item');
                        Account parentAcc = new Account (Oracle_Account_Number__c =String.valueOf(cssMap.get('accountNumber')));
                        Product2 parentProd = new Product2 (External_Id__c =prodId.substring(0,6));
                        CSS__c newCSS = new CSS__c(External_key__c = String.valueOf(cssMap.get('accountNumber')) + '-'+String.valueOf(cssMap.get('item'))+'-'+(String)cssMap.get('dataType'),
                        Account__r=parentAcc, Product__r = parentProd);
                        System.debug('css with external IDs: ' + newCSS.External_key__c + ' acc: ' +newCSS.Account__r + ' prod: ' + newCSS.Product__r);
                        newCSS.Jan__c = (Decimal)cssMap.get('jan');
                        newCSS.Feb__c = (Decimal)cssMap.get('feb');
                        newCSS.Mar__c = (Decimal)cssMap.get('mar');
                        newCSS.Apr__c = (Decimal)cssMap.get('apr');
                        newCSS.May__c = (Decimal)cssMap.get('may');
                        newCSS.Jun__c = (Decimal)cssMap.get('jun');
                        newCSS.Jul__c = (Decimal)cssMap.get('jul');
                        newCSS.Aug__c = (Decimal)cssMap.get('aug');
                        newCSS.Sep__c = (Decimal)cssMap.get('sep');
                        newCSS.Oct__c = (Decimal)cssMap.get('oct');
                        newCSS.Nov__c = (Decimal)cssMap.get('nov');
                        newCSS.Dec__c = (Decimal)cssMap.get('dec');
                        newCSS.Data_Type__c =(String) cssMap.get('dataType');
                        newCSS.Category__c = (String)cssMap.get('category');
                        if (String.valueOf(cssMap.get('accountNumber')) != 'no ite') {
                            cssToUps.add(newCSS);
                            System.debug('real css: '+cssToUps.size());
                        }     
                    }
                }
                // integer counter = 0;
                // while(counter<1600 && counter<cssToUps.size()) {
                //     cssToUpsLimit.add(cssToUps[counter++]);
                // }
                System.debug('upserted CSS: ' + cssToUps.size() +' - ' +cssToUps);
			    Database.UpsertResult[] cr = Database.upsert(cssToUps, c);
            }
            else if(type=='Sales Value ($)') {
                req.setEndpoint(endpoint+resource+'?dataType=Sales Value ($)');
                req.setMethod(method);
                req.setTimeout(120000);

                Blob headerValue = Blob.valueOf(username + ':' + password);
                String autorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);

                req.setHeader('Authorization', autorizationHeader);
                System.debug('Size: '+ Limits.getHeapSize() + 'Limit: '+Limits.getLimitHeapSize());
                res = h.send(req); 
                // System.debug('This is the body Sales Value ($) ' + res.getBody());
                if ( (res.getStatusCode() == 200 || res.getStatusCode()== 201)) {
                    
                    Map<String,Object> untypedMap = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                    List<Object> SalesValueMList = (List<Object>) untypedMap.get('records');                     
                    System.debug('Size: '+SalesValueMList.size() +'Data: ' + SalesValueMList);
                    for (Object d : SalesValueMList) {
                        System.debug('these are the results Sales Value ($): ' +d);
                        Map<string, Object> cssMap = (Map<string, Object>)d;
                        String prodId =(String)cssMap.get('item');
                        Account parentAcc = new Account (Oracle_Account_Number__c =String.valueOf(cssMap.get('accountNumber')));
                        Product2 parentProd = new Product2 (External_Id__c =prodId.substring(0,6));
                        CSS__c newCSS = new CSS__c(External_key__c = String.valueOf(cssMap.get('accountNumber')) + '-'+String.valueOf(cssMap.get('item'))+'-'+(String)cssMap.get('dataType'),
                        Account__r=parentAcc, Product__r = parentProd);
                        System.debug('css with external IDs: ' + newCSS.External_key__c + ' acc: ' +newCSS.Account__r + ' prod: ' + newCSS.Product__r);
                        newCSS.Jan__c = (Decimal)cssMap.get('jan');
                        newCSS.Feb__c = (Decimal)cssMap.get('feb');
                        newCSS.Mar__c = (Decimal)cssMap.get('mar');
                        newCSS.Apr__c = (Decimal)cssMap.get('apr');
                        newCSS.May__c = (Decimal)cssMap.get('may');
                        newCSS.Jun__c = (Decimal)cssMap.get('jun');
                        newCSS.Jul__c = (Decimal)cssMap.get('jul');
                        newCSS.Aug__c = (Decimal)cssMap.get('aug');
                        newCSS.Sep__c = (Decimal)cssMap.get('sep');
                        newCSS.Oct__c = (Decimal)cssMap.get('oct');
                        newCSS.Nov__c = (Decimal)cssMap.get('nov');
                        newCSS.Dec__c = (Decimal)cssMap.get('dec');
                        newCSS.Data_Type__c =(String) cssMap.get('dataType');
                        newCSS.Category__c = (String)cssMap.get('category');
                        if (String.valueOf(cssMap.get('item')) != 'no item') {
                            if (String.valueOf(cssMap.get('accountNumber')) != 'no item') {                                    
                                cssToUps.add(newCSS);
                                System.debug('real css: '+cssToUps.size());                                    
                            }   
                        }  
                    }
                }
                // integer counter = 0;
                // while(counter<1600 && counter<cssToUps.size()) {
                //     cssToUpsLimit.add(cssToUps[counter++]);
                // }
                System.debug('upserted CSS: ' + cssToUps.size() +' - ' +cssToUps);
			    Database.UpsertResult[] cr = Database.upsert(cssToUps, c);
            }
        // // }
                     
            
        // System.debug('CSS to upsert : ' + cssToUps.size() +' - '+cssToUps);
        // Database.UpsertResult[] cr = Database.upsert(cssToUps, c);
    }
}