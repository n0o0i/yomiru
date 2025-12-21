import axios from "axios";
import { application } from "express";
import { title } from "process";

export class RakutenBooksService {
    private readonly baseUrl = 'https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404';
    private readonly rankingUrl = 'https://app.rakuten.co.jp/services/api/BooksBook/Ranking/20121128';
    private readonly appId: string;

    constructor() {
        this.appId = process.env.RAKUTEN_APP_ID || '';
        if (!this.appId) {
            console.warn('RAKUTEN_APP_ID is not set.');
        }
    }

    public async searchBooks(keyword: string): Promise<any>{
        try {
            const response = await axios.get(this.baseUrl, {
                params: {
                    applicationId: this.appId,
                    title: keyword,
                    format: 'json',
                    hits: 10
                }
            });
            return response.data;
        } catch (error) {
            console.error('Rakuten books API error: ', error);
            throw new Error('Failed to search books from Rakuten books API');
        }
    }

    public async getRanking(): Promise<any> {
        try {
            const response = await axios.get(this.rankingUrl, {
                params: {
                    applicationId: this.appId,
                    booksGenreId: '001',
                    format: 'json'
                }
            });
            return response.data;
        } catch (error) {
            console.error('Rakuten Books API Ranking Error: ', error);
            throw new Error('Failed to get Books Ranking from Rakuten Books API');
        }
    }
}