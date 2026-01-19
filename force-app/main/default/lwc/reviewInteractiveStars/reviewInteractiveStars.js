import { LightningElement, api, wire } from 'lwc';
import getReviews from '@salesforce/apex/ReviewController.getReviews';
import createReview from '@salesforce/apex/ReviewController.createReview';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { getRecord } from 'lightning/uiRecordApi';
import AVERAGE from '@salesforce/schema/Product__c.Average_Rating__c';
import TOTAL from '@salesforce/schema/Product__c.Total_Reviews__c';

export default class ReviewInteractiveStars extends LightningElement {
    @api recordId;
    selectedRating = 0;

    stars = [
        { value: 1, class: 'star' },
        { value: 2, class: 'star' },
        { value: 3, class: 'star' },
        { value: 4, class: 'star' },
        { value: 5, class: 'star' }
    ];

    @wire(getReviews, { productId: '$recordId' })
    wiredReviews;

    @wire(getRecord, { recordId: '$recordId', fields: [AVERAGE, TOTAL] })
    product;

    get averageRating() {
        return this.product?.data?.fields?.Average_Rating__c?.value ?? '—';
    }

    get totalReviews() {
        return this.product?.data?.fields?.Total_Reviews__c?.value ?? '—';
    }

    handleStarClick(event) {
        this.selectedRating = Number(event.target.dataset.value);

        this.stars = this.stars.map(star => ({
            ...star,
            class: star.value <= this.selectedRating ? 'star selected' : 'star'
        }));
    }

    async submitRating() {
        if (this.selectedRating === 0) {
            this.showToast('Erro', 'Avaliação não selecionada', 'error');
            return;
        }

        try {
            await createReview({
                productId: this.recordId,
                rating: this.selectedRating,
                comment: 'comentario de teste',
                reviewer: 'fulano'
            });

            await Promise.all([
                refreshApex(this.wiredReviews),
                refreshApex(this.product)
            ]);

            this.showToast('Sucesso', 'Avaliação enviada', 'success');
            this.selectedRating = 0;
            this.refreshStars();
        } catch (error) {
            this.showToast('Erro', 'Falha ao enviar avaliação', 'error');
            console.error(error);
        }
    }

    refreshStars() {
        this.stars = this.stars.map(star => ({ ...star, class: 'star' }));
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}
