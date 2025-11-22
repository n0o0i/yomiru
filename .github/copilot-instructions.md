# Copilot Instructions for Yomiru

## 概要
YomiruはFlutter製の読書管理アプリで、バックエンドはTypeScript/Express.jsで構築されています。フロントエンド（`lib/`）とバックエンド（`backend/`）は分離されており、API連携でデータをやり取りします。

## アーキテクチャ
- **フロントエンド（Flutter）**
  - 主要画面は`lib/frontend/`配下に分割（例: `homePage.dart`, `Friends/`, `MyBooks/`など）。
  - データモデルは`lib/models/book_model.dart`で定義。Hiveでローカル保存。
  - サービス層（`lib/services/`）でAPI通信・設定管理（`api_service.dart`, `config_service.dart`, `hive_service.dart`）。
  - 設定は`ConfigService`でSharedPreferences管理。APIエンドポイントは`apiBaseUrl`で切り替え可能。

- **バックエンド（Express/TypeScript）**
  - 主要ロジックは`backend/src/`配下（`controllers/`, `services/`, `routes/`, `middleware/`, `types/`）。
  - API設計はRESTful。主なエンドポイントは`README.md`参照。
  - データ型は`Book`インターフェースで統一。

## 開発・ビルド・テスト
- **Flutterフロントエンド**
  - 開発: `flutter run`（デバイス指定可）
  - ビルド: `flutter build <platform>`
  - テスト: `flutter test`（テストは`test/`配下）
  - モデル自動生成: `flutter pub run build_runner build`（Hiveモデル用）

- **バックエンド**
  - 依存インストール: `npm install`（`backend/`で実行）
  - 開発サーバー: `npm run dev` または `npm run start:dev`
  - 本番ビルド: `npm run build` → `npm start` または `npm run start:prod`
  - テスト: `npm run test`
  - Lint: `npm run lint` / `npm run lint:fix`
  - 環境変数: `env.example`を`.env`にコピーして編集

## コーディング規約・パターン
- **Flutter**
  - データはHiveで永続化。`HiveService`経由でCRUD操作。
  - 設定値は`ConfigService`で取得・保存。
  - API通信は`api_service.dart`で一元管理。
  - 画面・ロジック分離を徹底（画面は`frontend/`、モデルは`models/`、サービスは`services/`）。

- **Express/TypeScript**
  - コントローラー/サービス/ルート/ミドルウェア分離。
  - バリデーションはJoi、ID生成はUUID。
  - レスポンスは`{ success, data, message }`形式で統一。

## 連携・外部依存
- Google Books API連携（APIキーは`ConfigService`で管理）
- バックエンドAPIは`ConfigService.apiBaseUrl`で指定
- ローカルストレージ・オフライン同期機能あり

## 参考ファイル
- `lib/main.dart`（アプリ起動・サービス初期化）
- `lib/services/hive_service.dart`（ローカルDB操作）
- `lib/services/config_service.dart`（設定管理）
- `lib/models/book_model.dart`（データモデル定義）
- `backend/README.md`（API設計・開発手順）
- `backend/package.json`（スクリプト・依存管理）

---

この内容が不明瞭・不足している場合は、具体的な改善点や追加情報を教えてください。