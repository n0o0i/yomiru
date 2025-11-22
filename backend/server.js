#!/usr/bin/env node

const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

// 環境変数の設定
process.env.NODE_ENV = process.env.NODE_ENV || 'development';

// ポート設定
const PORT = process.env.PORT || 3000;

// 開発環境かどうかの判定
const isDevelopment = process.env.NODE_ENV === 'development';

console.log(`🚀 Starting Yomiru Backend Server...`);
console.log(`📁 Working Directory: ${process.cwd()}`);
console.log(`🌍 Environment: ${process.env.NODE_ENV}`);
console.log(`🔌 Port: ${PORT}`);

// TypeScriptファイルの存在確認
const tsFile = path.join(__dirname, 'src', 'index.ts');
const jsFile = path.join(__dirname, 'dist', 'index.js');

if (isDevelopment) {
  // 開発環境: ts-nodeを使用してTypeScriptを直接実行
  console.log('🔧 Development Mode: Using ts-node');
  
  if (!fs.existsSync(tsFile)) {
    console.error('❌ Error: src/index.ts not found');
    process.exit(1);
  }

  const tsNode = spawn('npx', ['ts-node', 'src/index.ts'], {
    stdio: 'inherit',
    shell: true,
    env: { ...process.env, PORT }
  });

  tsNode.on('error', (error) => {
    console.error('❌ Error starting ts-node:', error);
    process.exit(1);
  });

  tsNode.on('exit', (code) => {
    console.log(`📤 ts-node exited with code ${code}`);
    process.exit(code);
  });

} else {
  // 本番環境: コンパイルされたJavaScriptを実行
  console.log('🏭 Production Mode: Using compiled JavaScript');
  
  if (!fs.existsSync(jsFile)) {
    console.error('❌ Error: dist/index.js not found. Please run "npm run build" first.');
    process.exit(1);
  }

  const node = spawn('node', ['dist/index.js'], {
    stdio: 'inherit',
    shell: true,
    env: { ...process.env, PORT }
  });

  node.on('error', (error) => {
    console.error('❌ Error starting Node.js:', error);
    process.exit(1);
  });

  node.on('exit', (code) => {
    console.log(`📤 Node.js exited with code ${code}`);
    process.exit(code);
  });
}

// プロセス終了時のクリーンアップ
process.on('SIGINT', () => {
  console.log('\n🛑 Received SIGINT. Shutting down gracefully...');
  process.exit(0);
});

process.on('SIGTERM', () => {
  console.log('\n🛑 Received SIGTERM. Shutting down gracefully...');
  process.exit(0);
});

// 未処理の例外をキャッチ
process.on('uncaughtException', (error) => {
  console.error('❌ Uncaught Exception:', error);
  process.exit(1);
});

process.on('unhandledRejection', (reason, promise) => {
  console.error('❌ Unhandled Rejection at:', promise, 'reason:', reason);
  process.exit(1);
});




