public with sharing class ReviewController {
    
    @AuraEnabled(cacheable=true)
    public static List<Review__c> getReviews(Id productId){
        return [SELECT Id, Name, Rating__c, Comment__c, Reviewer__c, Status__c 
                FROM Review__c 
                WHERE Product__c = :productId 
                ORDER BY CreatedDate DESC];
    }

    @AuraEnabled
    public static Review__c createReview(Id productId, Integer rating, String comment, String reviewer){
        Review__c review = new Review__c(
            Product__c = productId,
            Rating__c = rating,
            Comment__c = comment,
            Reviewer__c = reviewer,
            Status__c = 'Pendente'
        );
        insert review;
        return review;
    }
    @AuraEnabled
    public static Review__c updateReview(Id reviewId, Integer newRating){
        Review__c review = [SELECT Id, Rating__c FROM Review__c WHERE Id = :reviewID];
        review.Rating__c = newRating;
        update review;
        return review;
    }
}