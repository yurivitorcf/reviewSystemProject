@isTest
public class ReviewControllerTest {

    @isTest
    static void testGetReviews() {
        Product__c p = new Product__c(Name = 'Produto Teste');
        insert p;

        Review__c r = new Review__c(
            Product__c = p.Id,
            Rating__c = 4,
            Comment__c = 'Review inicial',
            Reviewer__c = 'Tester'
        );
        insert r;

        Test.startTest();
        List<Review__c> reviews = ReviewController.getReviews(p.Id);
        Test.stopTest();

        System.assertEquals(1, reviews.size(), 'Deve retornar 1 review');
    }

    @isTest
    static void testCreateReview() {
        Product__c p = new Product__c(Name = 'Produto Teste');
        insert p;

        Test.startTest();
        ReviewController.createReview(
            p.Id,
            5,
            'Novo review',
            'Outro Tester'
        );
        Test.stopTest();

        List<Review__c> allReviews = [
            SELECT Id, Rating__c, Comment__c
            FROM Review__c
            WHERE Product__c = :p.Id
        ];

        System.assertEquals(1, allReviews.size(), 'Deve ter 1 review criado');
    }
}
