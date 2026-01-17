public with sharing class ReviewTriggerHandler {
    public static void handler(){

        Set<Id> productIds = new Set<Id>();

        if(Trigger.isInsert){
            for(SObject review : Trigger.new){
                if((String)review.get('Status__c') == 'Aprovado'){
                    productIds.add((Id)review.get('Product__c'));
                }
            }
        }
        if(Trigger.isUpdate){
            for(SObject review : Trigger.new){
                SObject oldReview = Trigger.oldMap.get(review.Id);
                if(oldReview != null && ((String)review.get('Status__c') != (String)oldReview.get('Status__c') || review.get('Rating__c') != oldReview.get('Rating__c'))){
                    productIds.add((Id)review.get('Product__c'));
                }
            }
        }
        if(Trigger.isDelete){
            for(SObject review : Trigger.old){
                if((String)review.get('Status__c') == 'Aprovado'){
                    productIds.add((Id)review.get('Product__c'));
                }
            }
        }
        if(Trigger.isUndelete){
            for(SObject review : Trigger.new){
                if((String)review.get('Status__c') == 'Aprovado'){
                    productIds.add((Id)review.get('Product__c'));
                }
            }
        }
        if(!productIds.isEmpty()){
            //ainda para completar
        }
    }
}