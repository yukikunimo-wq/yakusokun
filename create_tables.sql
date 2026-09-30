-- Project Name : yakusokun
-- Date/Time    : 2026/09/14 12:07:50
-- Author       : H30709
-- RDBMS Type   : PostgreSQL
-- Application  : A5:SQL Mk-2

/*
  << 注意！！ >>
  BackupToTempTable, RestoreFromTempTable疑似命令が付加されています。
  これにより、drop table, create table 後もデータが残ります。
  この機能は一時的に $$TableName のような一時テーブルを作成します。
  この機能は A5:SQL Mk-2でのみ有効であることに注意してください。
*/

-- カテゴリ
-- * BackupToTempTable
drop table if exists categories cascade;

-- * RestoreFromTempTable
create table categories (
  id INTEGER not null
  , name VARCHAR(10)
  , color_code VARCHAR(7)
  , constraint categories_PKC primary key (id)
) ;

-- 収支カテゴリ
-- * BackupToTempTable
drop table if exists expense_categories cascade;

-- * RestoreFromTempTable
create table expense_categories (
  id INTEGER not null
  , name VARCHAR(10)
  , type CHAR(2)
  , color_code VARCHAR(7)
  , constraint expense_categories_PKC primary key (id)
) ;

-- 収支目標設定
-- * BackupToTempTable
drop table if exists monthly_budgets cascade;

-- * RestoreFromTempTable
create table monthly_budgets (
  id SERIAL not null
  , user_id INTEGER not null
  , target_month VARCHAR(7) not null
  , income_amount INTEGER default 0
  , target_expense INTEGER default 0
  , constraint monthly_budgets_PKC primary key (id)
) ;

-- 収支履歴
-- * BackupToTempTable
drop table if exists transactions cascade;

-- * RestoreFromTempTable
create table transactions (
  id SERIAL not null
  , user_id INTEGER not null
  , type CHAR(2) not null
  , date DATE not null
  , category_id INTEGER not null
  , amount INTEGER not null
  , memo VARCHAR(50)
  , created_at TIMESTAMP
  , constraint transactions_PKC primary key (id)
) ;

-- スケジュール
-- * BackupToTempTable
drop table if exists schedules cascade;

-- * RestoreFromTempTable
create table schedules (
  id SERIAL not null
  , user_id INTEGER not null
  , day_time DATE not null
  , title VARCHAR(10) not null
  , category_id INTEGER not null
  , start_time TIME not null
  , end_time TIME not null
  , memo VARCHAR(30)
  , has_alarm BOOLEAN default FALSE
  , alarm_minutes_before INTEGER
  , created_at TIMESTAMP default CURRENT_TIMESTAMP
  , constraint schedules_PKC primary key (id)
) ;

-- ユーザー情報
-- * BackupToTempTable
drop table if exists users cascade;

-- * RestoreFromTempTable
create table users (
  id SERIAL not null
  , email character varying(255) not null
  , password_digest character varying(255) not null
  , constraint users_PKC primary key (id)
) ;

comment on table categories is 'カテゴリ';
comment on column categories.id is 'カテゴリid:マスタとして固定IDを登録';
comment on column categories.name is 'カテゴリ名';
comment on column categories.color_code is 'カテゴリカラー';

comment on table expense_categories is '収支カテゴリ';
comment on column expense_categories.id is '収支カテゴリid:マスタとして固定ID';
comment on column expense_categories.name is '収支カテゴリ名';
comment on column expense_categories.type is '収支区分:マスタ登録　01：収入、02：出費';
comment on column expense_categories.color_code is '収支カラーコード';

comment on table monthly_budgets is '収支目標設定';
comment on column monthly_budgets.id is '収支目標設定id:自動採番';
comment on column monthly_budgets.user_id is 'ユーザーid:外部キー：users.id';
comment on column monthly_budgets.target_month is '対象の年月';
comment on column monthly_budgets.income_amount is '収入金額:初回入力時は0';
comment on column monthly_budgets.target_expense is '目標出費額:初回入力時は0';

comment on table transactions is '収支履歴';
comment on column transactions.id is '収支履歴id:自動採番';
comment on column transactions.user_id is 'ユーザーid:外部キー:users.id';
comment on column transactions.type is '収支区分:01：収入/02:出費を選択';
comment on column transactions.date is '日付';
comment on column transactions.category_id is '収支カテゴリid:外部キー:expense_categories.id';
comment on column transactions.amount is '金額';
comment on column transactions.memo is 'メモ:未入力ならNULL';
comment on column transactions.created_at is 'タイムスタンプ:CURRENT_TIMESTAMP';

comment on table schedules is 'スケジュール';
comment on column schedules.id is 'スケジュールid:自動採番';
comment on column schedules.user_id is 'ユーザーid:外部キー：users.id';
comment on column schedules.day_time is '日付';
comment on column schedules.title is 'タイトル';
comment on column schedules.category_id is 'カテゴリid';
comment on column schedules.start_time is '開始日時';
comment on column schedules.end_time is '終了日時';
comment on column schedules.memo is '内容:未入力ならNULL';
comment on column schedules.has_alarm is 'アラーム:新規予定はアラームOFF';
comment on column schedules.alarm_minutes_before is 'アラーム通知:アラームON時に選択';
comment on column schedules.created_at is 'タイムスタンプ:登録日時を自動設定';

comment on table users is 'ユーザー情報';
comment on column users.id is 'ユーザーid:自動採番';
comment on column users.email is 'メールアドレス';
comment on column users.password_digest is 'パスワード:ハッシュ化した値を登録';

