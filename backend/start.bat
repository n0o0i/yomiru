@echo off
REM Yomiru Backend Server Startup Script for Windows
REM 使用方法: start.bat [development|production]

setlocal enabledelayedexpansion

REM 環境の設定
set ENVIRONMENT=%1
if "%ENVIRONMENT%"=="" set ENVIRONMENT=development
set PORT=%PORT%
if "%PORT%"=="" set PORT=3000

echo.
echo 🚀 Starting Yomiru Backend Server...
echo 📁 Working Directory: %CD%
echo 🌍 Environment: %ENVIRONMENT%
echo 🔌 Port: %PORT%
echo.

REM 依存関係の確認
if not exist "node_modules" (
    echo ⚠️  node_modules not found. Installing dependencies...
    call npm install
    if errorlevel 1 (
        echo ❌ Failed to install dependencies
        exit /b 1
    )
)

REM 環境変数ファイルの確認
if not exist ".env" (
    if exist "env.example" (
        echo ⚠️  .env file not found. Copying from env.example...
        copy env.example .env
        echo ⚠️  Please edit .env file with your configuration
    ) else (
        echo ❌ .env file not found and env.example not available
        exit /b 1
    )
)

REM 環境に応じた処理
if "%ENVIRONMENT%"=="production" (
    echo 🏭 Production mode: Building and starting...
    
    REM TypeScriptのコンパイル
    echo 📦 Compiling TypeScript...
    call npm run build
    if errorlevel 1 (
        echo ❌ Build failed
        exit /b 1
    )
    
    if not exist "dist\index.js" (
        echo ❌ Build failed. dist\index.js not found
        exit /b 1
    )
    
    echo ✅ Build completed successfully
    
    REM 本番サーバー起動
    echo 🚀 Starting production server...
    set NODE_ENV=production
    node dist\index.js
    
) else if "%ENVIRONMENT%"=="development" (
    echo 🔧 Development mode: Starting with hot reload...
    
    REM 開発サーバー起動
    call npm run dev
    
) else (
    echo ❌ Invalid environment: %ENVIRONMENT%
    echo ℹ️  Usage: start.bat [development|production]
    exit /b 1
)

REM エラーハンドリング
if errorlevel 1 (
    echo ❌ Server failed to start
    exit /b 1
)




