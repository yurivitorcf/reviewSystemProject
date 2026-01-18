@isTest
private class ReviewTriggerHelperTest {

    @isTest
    static void testReviewTriggerHelper() {
        Product__c p = new Product__c(Name = 'Produto Teste');
        insert p;

        Review__c r1 = new Review__c(Product__c = p.Id, Rating__c = 4, Status__c = 'Aprovado', Reviewer__c = 'fulano1');
        Review__c r2 = new Review__c(Product__c = p.Id, Rating__c = 2, Status__c = 'Aprovado', Reviewer__c = 'fulano2');
        Review__c r3 = new Review__c(Product__c = p.Id, Rating__c = 1, Status__c = 'Pendente', Reviewer__c = 'fulano3');
        insert new List<Review__c>{r1, r2, r3};

        p = [SELECT Average_Rating__c, Total_Reviews__c FROM Product__c WHERE Id = :p.Id];
        System.assertEquals(3.0, p.Average_Rating__c);
        System.assertEquals(2, p.Total_Reviews__c);

        delete r2;

        p = [SELECT Average_Rating__c, Total_Reviews__c FROM Product__c WHERE Id = :p.Id];
        System.assertEquals(4.0, p.Average_Rating__c);
        System.assertEquals(1, p.Total_Reviews__c);
    }
}
