# Yomiru Backend API

YomiruアプリのバックエンドAPIサーバーです。TypeScript + Express.jsで構築されています。

## 🚀 セットアップ

### 1. 依存関係のインストール

```bash
cd backend
npm install
```

### 2. 環境変数の設定

```bash
cp env.example .env
```

`.env`ファイルを編集して必要な設定を行ってください。

### 3. 開発サーバーの起動

```bash
# 開発モード（ホットリロード付き）
npm run dev

# 本番ビルド
npm run build
npm start
```

## 📚 API エンドポイント

### 本の管理

- `GET /api/books` - 本の一覧取得
- `GET /api/books/:id` - 本の詳細取得
- `POST /api/books` - 本の追加
- `PUT /api/books/:id` - 本の更新
- `DELETE /api/books/:id` - 本の削除
- `GET /api/books/search/:query` - 本の検索

### ヘルスチェック

- `GET /health` - サーバーの状態確認

## 🛠️ 開発

### 利用可能なスクリプト

```bash
# 開発用
npm run dev         # 開発サーバー起動（ホットリロード）
npm run start:dev   # 開発環境でサーバー起動

# 本番用
npm run build       # TypeScriptコンパイル
npm run start       # 本番サーバー起動
npm run start:prod  # 本番環境でサーバー起動

# ユーティリティ
npm run server      # 環境に応じて自動選択
npm run test        # テスト実行
npm run lint        # リンター実行
npm run lint:fix    # リンター自動修正
```

### サーバー起動方法

#### 方法1: npmスクリプトを使用
```bash
# 開発環境
npm run dev
# または
npm run start:dev

# 本番環境
npm run build
npm run start
# または
npm run start:prod
```

#### 方法2: server.jsを直接実行
```bash
# 開発環境
NODE_ENV=development node server.js

# 本番環境
NODE_ENV=production node server.js
```

#### 方法3: シェルスクリプトを使用（Unix/Linux/macOS）
```bash
# 開発環境
./start.sh development

# 本番環境
./start.sh production
```

#### 方法4: バッチファイルを使用（Windows）
```cmd
# 開発環境
start.bat development

# 本番環境
start.bat production
```

### プロジェクト構造

```
src/
├── controllers/    # コントローラー
├── services/       # ビジネスロジック
├── routes/         # ルート定義
├── middleware/     # ミドルウェア
├── types/          # TypeScript型定義
└── index.ts        # エントリーポイント
```

## 🔧 技術スタック

- **Node.js** - ランタイム環境
- **TypeScript** - 型安全なJavaScript
- **Express.js** - Webフレームワーク
- **Joi** - バリデーション
- **UUID** - 一意ID生成
- **CORS** - クロスオリジン設定
- **Helmet** - セキュリティヘッダー

## 📝 API仕様

### 本のデータ構造

```typescript
interface Book {
  id: string;
  title: string;
  author: string;
  publisher?: string;
  isbn?: string;
  status: 'read' | 'to_read';
  rating?: number;
  dateAdded: string;
  dateRead?: string;
  memo?: string;
  tags?: string[];
  createdAt: string;
  updatedAt: string;
}
```

### レスポンス形式

```json
{
  "success": true,
  "data": { ... },
  "message": "Success message"
}
```

## 🚀 デプロイ

1. 本番環境用にビルド
```bash
npm run build
```

2. 本番サーバー起動
```bash
npm start
```

## 📄 ライセンス

MIT License

