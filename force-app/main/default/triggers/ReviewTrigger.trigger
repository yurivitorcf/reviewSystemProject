trigger ReviewTrigger on Review__C (after insert, after update, after delete, after undelete) {   
    
    ReviewTriggerHandler.handler();
}