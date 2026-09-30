# アプリケーション「やくそくん」

[![Java](https://img.shields.io/badge/Java-25-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://openjdk.org/)
[![Apache Tomcat](https://img.shields.io/badge/Apache_Tomcat-11-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black)](https://tomcat.apache.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18.1-316192?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![AWS](https://img.shields.io/badge/AWS-EC2-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Google Gemini](https://img.shields.io/badge/Google_Gemini-API-8E75C2?style=for-the-badge&logo=google-gemini&logoColor=white)](https://ai.google.dev/)
[![Eclipse](https://img.shields.io/badge/Eclipse-IDE-2C2255?style=for-the-badge&logo=eclipse-ide&logoColor=white)](https://www.eclipse.org/)
[![A5:SQL Mk-2](https://img.shields.io/badge/DB_Tool-A5:SQL_Mk--2-2D5986?style=for-the-badge)](https://a5m2.mmatsubara.com/)
[![Antigravity](https://img.shields.io/badge/Dev_Tool-Antigravity-4285F4?style=for-the-badge)](https://antigravity.google/)

予定や約束を直感的に共有・管理できるカレンダー機能と、AI（Gemini API）によるアドバイス機能を備えた家計簿を統合したWebアプリケーションです。  
日々のスケジュールと収支状況をシンプルに一元管理し、ユーザーが迷わず直感的に使えるUIと安定したデータ管理・外部連携を意識して開発しました。

> [!NOTE]  
> **本プロジェクトは、Java実習時に作成したコンテンツ（ポートフォリオ）です。**  
> * **開発期間**: 26日  (要件定義、PD、PG)
> * **開発規模**: 2.5Kstep  
> 
> Java実習の内容は以下よりご覧いただけます。  
> 👉 **[Java実習の内容はこちら](https://github.com/yukikunimo-wq/yakusokun)**  
> *(※別タブで開く場合は Ctrl + クリック / Cmd + クリック 推奨)*

---

## 📑 目次
1. [💻 画面イメージ](#-画面イメージ)
2. [✨ 主な機能](#-主な機能)
3. [🧰 使用技術・開発環境](#-使用技術開発環境)
4. [📐 システム構成](#-システム構成)
5. [🌐 動作確認（デモ環境）](#-動作確認デモ環境)
6. [📖 要件定義書・画面設計書](#-要件定義書画面設計書)
7. [🛠️ ローカル環境での実行・セットアップ手順](#️-ローカル環境での実行セットアップ手順)
8. [💡 工夫した点](#-工夫した点)
9. [🧗 苦労した点・得られた教訓](#-苦労した点得られた教訓)

---

## 💻 画面イメージ

*(※ 掲載している画像はシステム画面の一部抜粋です。全画面イメージや詳細な画面フローは [要件定義書・画面設計書](#-要件定義書画面設計書) よりご覧いただけます)*

| カレンダー（予定・約束管理）<br><sub>※一部抜粋</sub> | 家計簿（収支管理 & AIアドバイス）<br><sub>※一部抜粋</sub> |
| :---: | :---: |
| <img src="readme_img/main1.png" width="360" alt="カレンダー画面"> | <img src="readme_img/main2.png" width="360" alt="家計簿画面"> |
| 予定や用事、天気を月間カレンダーで一覧確認 | 日別収支、目標残高、Geminiによる個別アドバイス |

---

## ✨ 主な機能

* 📅 **予定・約束管理（カレンダー）**
  * 日常の予定、約束、用事（美容・仕事・遊び・通院・買い物など）の直感的な登録・確認
  * 天候・降水確率情報と連動したスケジュール把握
* 💰 **家計簿・収支管理**
  * 日ごとの支出・収入の直感的な記録とカレンダー形式での可視化
  * 今月の支出合計・支出残高・目標到達比率のリアルタイム算出
* 🤖 **AIによる家計アドバイス（Gemini API連携）**
  * 登録された支出傾向や予算状況、外部要因（天気など）を総合的に分析
  * パーソナライズされた節約アドバイス・評価コメントを自動生成  
    *(※ 利用にはGemini APIキーの指定が必要です)*
* 🔐 **認証・アカウント機能**
  * ユーザーログイン・ログアウト機能（ゲストログイン対応）

---

## 🧰 使用技術・開発環境

| カテゴリ | 技術スタック / バージョン |
| :--- | :--- |
| **開発期間** | 26日 |
| **開発規模** | 2.5Kstep |
| **言語・ランタイム** | Java 25 (OpenJDK) |
| **Webコンテナ / APサーバ** | Apache Tomcat 11 |
| **バックエンドフレームワーク** | Java (Servlet / JSP) |
| **データベース** | PostgreSQL 18.1（テーブル生成用 [DDL.sql](DDL.sql) を同梱） |
| **インフラ / ホスティング** | AWS (EC2) |
| **AI API** | Google Gemini API |
| **統合開発環境 (IDE)** | Eclipse |
| **DB管理・設計ツール** | A5:SQL Mk-2 |
| **開発支援（AI）** | Antigravity |

---

## 📐 システム構成

```mermaid
graph LR
    User([ユーザー / ブラウザ]) -->|HTTP / HTTPS| WebServer["AWS EC2<br>(Apache Tomcat 11 / Java 25)"]
    WebServer -->|JDBC| DB[("PostgreSQL 18.1")]
    WebServer -->|API Request / JSON| Gemini["Google Gemini API<br>(家計状況分析・アドバイス生成)"]
```

---

## 🌐 動作確認（デモ環境）

AWS上にデプロイしており、実際に動作をご確認いただけます。

👉 **[「やくそくん」デモサイトはこちら](http://13.193.142.78/yakusokun)**  
*(※別タブで開く場合は `Ctrl + クリック` / `Cmd + クリック` 推奨)*

> **テスト用ログイン情報**  
> * **ID**: `guest_user@example.com`  
> * **パスワード**: `password123`

---

## 📖 要件定義書・画面設計書

👉 **[Web版 要件定義書・画面設計書はこちら（GitHub Pages）](https://hadano-nobuyuki.github.io/project/)**  
*(※リンクを別タブで開く場合は `Ctrl + クリック`（Macは `Cmd + クリック`）してください)*  
*(※システム仕様・各画面イメージ・業務フローの詳細をWebページ形式でご覧いただけます)*

---

## 🛠️ ローカル環境での実行・セットアップ手順

ローカル環境で本プロジェクトを実行する場合は、以下の環境準備、データベースのセットアップ、APIキーの設定、およびデータベース接続設定が必要です。

### 1. 前提条件
* **Java**: JDK 25
* **Webコンテナ**: Apache Tomcat 11
* **データベース**: PostgreSQL 18.1
  * ※ プログラムを実行する際に必要な環境として、データベースのテーブル生成用DDL（[`DDL.sql`](DDL.sql)）をプロジェクトルート直下に公開・同梱しています。
* **Gemini APIキー**: Google AI Studio等で取得したAPIキー

### 2. データベースの構築（テーブル生成用DDLの実行）
プログラムの実行に必要なテーブル群を生成するため、公開しているテーブル生成用DDL（[`DDL.sql`](DDL.sql)）を実行してください。

1. PostgreSQLにて任意のデータベース（例: `yakusokun`）を作成します。
2. 作成したデータベースに対して、プロジェクトルート直下の [`DDL.sql`](DDL.sql) を実行してテーブルを作成します。  
   *(※ A5:SQL Mk-2、pgAdmin、または `psql` コマンドライン等から実行可能です)*

### 3. 環境変数の設定（Gemini APIキー）
AIアドバイス機能を利用するためには、**Gemini APIキーの指定が必要**です。  
OSまたは実行環境の環境変数 **`GEMINI_API_KEY`** に取得したAPIキーを登録してください。

* **Windows (PowerShell)**:
  ```powershell
  # 永続設定（ユーザー環境変数）
  [System.Environment]::SetEnvironmentVariable('GEMINI_API_KEY', 'your_gemini_api_key_here', 'User')

  # または現在のセッションのみ一時設定
  $env:GEMINI_API_KEY="your_gemini_api_key_here"
  ```
* **Linux / macOS (Bash / Zsh)**:
  ```bash
  export GEMINI_API_KEY="your_gemini_api_key_here"
  ```
> *(※ TomcatなどのAPサーバを起動する実行環境から本環境変数が参照できるように設定してください)*

### 4. データベース設定ファイルの作成
セキュリティ保護のため設定ファイル自体はリポジトリ管理外となっています。  
`/src/main/java/` 配下に `db.properties` を作成し、ご自身のローカルDB環境に合わせて接続情報を設定してください。

> **リポジトリ内に `db.properties.sample` を用意していますので、リネームしてご利用いただけます。**

#### `db.properties` の記述例
```properties
db.url=jdbc:postgresql://localhost:5432/データベース名
db.user=ユーザ名
db.password=パスワード
db.driver=org.postgresql.Driver
```

---

## 💡 工夫した点

### 1. AIを活用した家計状況の評価
* **Gemini API** を使用し、ユーザーの支出データから支出傾向や改善ポイントを自動分析・評価させる仕組みを構築しました。天候情報と組み合わせるなど、実践的な節約アドバイスが得られるように工夫しています。

### 2. プログラミングの効率化
AI（Antigravity）にコーディングを実施させることで、開発効率を大幅に高める施策をとりました。

* **アプローチ内容**:
  * 要件定義書からプログラム設計書を作成
  * プログラム設計書を基にAIにてコーディングを実施
  * AIが生成したプログラムを確認し、改善箇所を抽出して対策を実施  
    *(※ 着目した改善箇所：セキュリティ上のリスク、性能向上箇所の有無)*

---

## 🧗 苦労した点・得られた教訓

### 1. AIが生成するプログラムの品質確保と設計書の整合性
プログラム設計書の記載内容に曖昧な箇所があると、生成されるプログラムに想定外のロジックが組み込まれる事象が多発しました。  
また、一部の不整合を解消するために設計書を部分的に修正すると、その変更が引き金となり、生成されるプログラムの他の部分で新たな問題（デグレード）が発生するという課題にも直面しました。そのため、修正を行う際には単所的な対応にとどまらず、**設計書全体の整合性を保ちながら、すべての曖昧な記述を徹底的に洗い出して修正すること**に非常に苦労しました。

この試行錯誤を繰り返した結果、以下の教訓を得ることができました。
* プログラム設計書が満たすべき必要十分条件（一貫性と明確さ）の重要性
* プログラムを修正する際には、常に設計書全体へのフィードバックと整合性の再検証が不可欠であること
* 全機能を再作成させるか、一部機能のみを再作成するかの判断基準の必要性

### 2. 開発期間（26日間）の逼迫に伴う、実装スコープの見直しと思考プロセス
開発の初期・構築段階において、明確な優先順位を定義しきれないまま「実装したい魅力的な機能」を次々と追加してしまいました。その結果、中間フェーズに差し掛かった時点で、**このままのペースでは26日間という限られた開発期間内に完成が間に合わない**ことが判明しました。

ここでただ闇雲に作業を焦るのではなく、一度立ち止まって**「限られた時間の中で、このアプリケーションがユーザーに提供すべき一番のコア価値は何か」**を徹底的に考え直しました。

具体的には、以下のような思考・検討プロセスを経て計画を再設計しました。
* **コア価値の再定義**: 本アプリの本質は「予定と家計簿が連動し、AIがアドバイスをくれること」であり、それ以外の装飾的なUIや高度な通知機能は「あれば嬉しい（Nice to have）」レベルであると整理。
* **トレードオフの決断**: 期間内に「バグだらけの多機能アプリ」を作るよりも、「機能はシンプルだが安定して動作するアプリ」を完成させる方がポートフォリオとして品質が高いと判断。
* **スコープの削ぎ落とし**: 優先順位の低い機能を泣く泣くカットし、確実にデリバリー（期日通りの完成）ができる現実的なラインへスケジュールとタスクを再定義。

この経験から、**「要件定義や構築の初期段階から期間を見据えたスコープ管理を行う重要性」**と、**「状況に応じて柔軟に優先順位を判断し、期限内に成果物を形にするための意思決定力」**の必要性を痛感しました。

---

これらの教訓は、実務におけるAI協調型開発や、限られたリソースでのプロジェクトマネジメントにおいても、品質と納期を両立させるための非常に役立つ知見であると確信しています。
