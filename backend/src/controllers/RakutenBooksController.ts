import { Request, Response } from "express";
import { RakutenBooksService } from "@/services/RakutenBooksService";

export class RakutensBooksController {
    private rakutenBooksService: RakutenBooksService;

    constructor() {
        this.rakutenBooksService = new RakutenBooksService();
    }

    public searchBooks = async (req: Request, res: Response): Promise<void> {
        try {
            const 
        }
    }
}