trigger ReviewTrigger on Review__C (after insert, after update, after delete, after undelete) {   
    if(Trigger.isInsert){

    }
    if(Trigger.isUpdate){

    }
    if(Trigger.isDelete){
        
    }
    if(Trigger.isUndelete){

    }
}