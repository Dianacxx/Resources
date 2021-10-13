global class BIG_BatchDeleteAging implements Database.Batchable<SObject>, Schedulable 
{
 
    global BIG_BatchDeleteAging()
    {
        //Setup anything needed 
    }
    
    global Database.QueryLocator start(Database.BatchableContext context)  
    {
        string query; 
        if(!Test.isRunningTest())
            query = 'SELECT id  FROM Aging__c ';
        else
            query = 'SELECT id  FROM Aging__c  limit 10' ;
    
        return Database.getQueryLocator(query);
    } 
    global void execute(SchedulableContext sc)
    {
        Database.executeBatch(new BIG_BatchDeleteAging());
    }

    global void execute(Database.BatchableContext context, List<SOBject> Sobjectlist) 
    { 
        list<ID> recycleIDs = new list<Id>();
        system.debug('&& the number of records in Aging is ' + Sobjectlist.size());
        for(sObject s : Sobjectlist)
        {
            //Cast record
            Aging__c del = (Aging__c)s;  
            //Add ID to recyle delete 
            RecycleIDs.add(del.id); 
        }
    
        system.debug('&& about to do delete ');
        if(!Sobjectlist.isEmpty())
            delete Sobjectlist; 
            
        if(!RecycleIDs.isEmpty())
            Database.emptyRecycleBin(RecycleIDs); 
    }
    
    global void finish(Database.BatchableContext BC){
        

    }
}