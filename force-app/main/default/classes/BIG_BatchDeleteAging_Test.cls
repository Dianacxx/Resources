@isTest
private class BIG_BatchDeleteAging_Test {

    static testMethod void BIG_BatchDeleteAging_Test() 
    {
        Account acct = new Account(name='Test acct', External_Key__c='123-Miller', Oracle_Account_Number__c='123');
        insert acct; 
        
        list<Aging__c> aglist = new list<Aging__c>(); 
        Aging__c ag1 = new Aging__c(Customer__c = acct.id, current__c = 100, external_key__c='123-1'); 
        aglist.add(ag1); 
        ag1 = new Aging__c(Customer__c = acct.id, current__c = 100, external_key__c='123-2'); 
        aglist.add(ag1); 
        ag1 = new Aging__c(Customer__c = acct.id, current__c = 100, external_key__c='123-3'); 
        aglist.add(ag1); 
        ag1 = new Aging__c(Customer__c = acct.id, current__c = 100, external_key__c='123-4'); 
        aglist.add(ag1); 
        ag1 = new Aging__c(Customer__c = acct.id, current__c = 100, external_key__c='123-5'); 
        aglist.add(ag1); 

        insert aglist;

        Test.StartTest();
        
        BIG_BatchDeleteAging Batchrun = new BIG_BatchDeleteAging();
        SchedulableContext sc;
        Batchrun.execute(sc);        
        
        Test.StopTest();
        
    }
}