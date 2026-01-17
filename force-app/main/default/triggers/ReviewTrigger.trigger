trigger ReviewTrigger on Review__c (after insert, after update, after delete, after undelete) {   
    
  ReviewTriggerHandler.handler();
}
