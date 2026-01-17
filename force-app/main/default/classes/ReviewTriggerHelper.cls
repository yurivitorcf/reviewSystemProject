public with sharing class ReviewTriggerHelper {
    public static void updateProductRatings(Set<Id> productIds){

        List<AggregateResult> results = [
            SELECT 
                Product__c,
                AVG(Rating__c) averageRating,
                COUNT(Id) totalReviews
            FROM Review__c
            WHERE Product__c IN :productIds
            AND Status__c = 'Aprovado'
            GROUP BY Product__c
        ];
        
        List<Product__c> productsToUpdate = new List<Product__c>();

        for(AggregateResult aggResults : results){
            Product__c product = new Product__c(
                Id = (Id)aggResults.get('Product__c'),
                Average_Rating__c = (Decimal)aggResults.get('averageRating'),
                Total_Reviews__c = (Integer)aggResults.get('totalReviews')
            );
            productsToUpdate.add(product);
        }

        Set<Id> productsWithReviews = new Set<Id>();
        for(AggregateResult aggResults : results){
            productsWithReviews.add((Id)aggResults.get('Product__c'));  
        }

        for(Id productId : productIds){
            if(!productsWithReviews.contains(productId)){
                Product__c product = new Product__c(
                    Id = productId,
                    Average_Rating__c = 0,
                    Total_Reviews__c = 0
                );
                productsToUpdate.add(product);
            }
        }

        if(!productsToUpdate.isEmpty()){
            update productsToUpdate;
        }
    }
}