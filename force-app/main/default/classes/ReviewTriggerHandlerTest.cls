@isTest
private class ReviewTriggerHandlerTest {

    @isTest
    static void testReviewTriggerHandler() {
        Product__c p = new Product__c(Name = 'Produto Teste');
        insert p;

        Review__c r = new Review__c(
            Product__c = p.Id,
            Rating__c = 5,
            Status__c = 'Aprovado',
            Reviewer__c = 'fulano1'
        );
        insert r;

        p = [SELECT Total_Reviews__c FROM Product__c WHERE Id = :p.Id];
        System.assertEquals(1, p.Total_Reviews__c);
    }
}
