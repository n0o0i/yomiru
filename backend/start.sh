#!/bin/bash

# Yomiru Backend Server Startup Script
# 使用方法: ./start.sh [development|production]

set -e

# 色付きのログ出力
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ログ関数
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# 環境の設定
ENVIRONMENT=${1:-development}
PORT=${PORT:-3000}

log_info "Starting Yomiru Backend Server..."
log_info "Environment: $ENVIRONMENT"
log_info "Port: $PORT"

# 依存関係の確認
if [ ! -d "node_modules" ]; then
    log_warning "node_modules not found. Installing dependencies..."
    npm install
fi

# 環境変数ファイルの確認
if [ ! -f ".env" ]; then
    if [ -f "env.example" ]; then
        log_warning ".env file not found. Copying from env.example..."
        cp env.example .env
        log_warning "Please edit .env file with your configuration"
    else
        log_error ".env file not found and env.example not available"
        exit 1
    fi
fi

# 環境に応じた処理
if [ "$ENVIRONMENT" = "production" ]; then
    log_info "Production mode: Building and starting..."
    
    # TypeScriptのコンパイル
    log_info "Compiling TypeScript..."
    npm run build
    
    if [ ! -f "dist/index.js" ]; then
        log_error "Build failed. dist/index.js not found"
        exit 1
    fi
    
    log_success "Build completed successfully"
    
    # 本番サーバー起動
    log_info "Starting production server..."
    NODE_ENV=production node dist/index.js
    
elif [ "$ENVIRONMENT" = "development" ]; then
    log_info "Development mode: Starting with hot reload..."
    
    # 開発サーバー起動
    npm run dev
    
else
    log_error "Invalid environment: $ENVIRONMENT"
    log_info "Usage: ./start.sh [development|production]"
    exit 1
fi




