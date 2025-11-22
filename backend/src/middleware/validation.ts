import { Request, Response, NextFunction } from 'express';
import Joi from 'joi';

// 本の作成・更新用バリデーションスキーマ
const bookSchema = Joi.object({
  title: Joi.string().min(1).max(200).required().messages({
    'string.empty': 'タイトルは必須です',
    'string.min': 'タイトルは1文字以上である必要があります',
    'string.max': 'タイトルは200文字以内である必要があります'
  }),
  author: Joi.string().min(1).max(100).required().messages({
    'string.empty': '著者は必須です',
    'string.min': '著者は1文字以上である必要があります',
    'string.max': '著者は100文字以内である必要があります'
  }),
  publisher: Joi.string().max(100).optional().messages({
    'string.max': '出版社は100文字以内である必要があります'
  }),
  isbn: Joi.string().pattern(/^\d{10}(\d{3})?$/).optional().messages({
    'string.pattern.base': 'ISBNは10桁または13桁の数字である必要があります'
  }),
  status: Joi.string().valid('read', 'to_read').required().messages({
    'any.only': 'ステータスは「read」または「to_read」である必要があります'
  }),
  rating: Joi.number().min(0).max(5).optional().messages({
    'number.min': '評価は0以上である必要があります',
    'number.max': '評価は5以下である必要があります'
  }),
  dateRead: Joi.date().iso().optional().messages({
    'date.format': '読了日はISO形式の日付である必要があります'
  }),
  memo: Joi.string().max(1000).optional().messages({
    'string.max': 'メモは1000文字以内である必要があります'
  }),
  tags: Joi.array().items(Joi.string().max(50)).optional().messages({
    'array.items': 'タグは50文字以内の文字列である必要があります'
  })
});

export const validateBook = (req: Request, res: Response, next: NextFunction): void => {
  const { error } = bookSchema.validate(req.body, { abortEarly: false });
  
  if (error) {
    const errorMessages = error.details.map(detail => detail.message);
    res.status(400).json({
      success: false,
      error: 'Validation Error',
      messages: errorMessages
    });
    return;
  }
  
  next();
};





