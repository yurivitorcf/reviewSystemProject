public with sharing class ReviewTriggerHandler {
    public static void handler(){

        Set<Id> productIds = new Set<Id>();

        if(Trigger.isInsert){
            for(Review__c review : Trigger.new){
                if(review.Status__c == 'Aprovado'){
                    productIds.add(review.Product__c);
                }
            }
        }
        if(Trigger.isUpdate){
            for(Review__c review : Trigger.new){
                Review__c oldReview = Trigger.oldMap.get(review.Id);
                if(review.Status__c != oldReview.Status__c || review.Rating__c != oldReview.Rating__c){
                    productIds.add(review.Product__c);
                }
            }
        }
        if(Trigger.isDelete){
            for(Review__c review : Trigger.old){
                if(review.Status__c == 'Aprovado'){
                    productIds.add(review.Product__c);
                }
            }
        }
        if(Trigger.isUndelete){
            for(Review__c review : Trigger.new){
                if(review.Status__c == 'Aprovado'){
                    productIds.add(review.Product__c);
                }
            }
        }
        if(!productIds.isEmpty()){
            //ainda para completar
        }
    }
}