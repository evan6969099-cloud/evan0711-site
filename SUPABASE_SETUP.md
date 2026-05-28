# Supabase 免费档配置

## 1. 创建项目

1. 打开 https://supabase.com/dashboard
2. 新建一个 Free 项目。
3. 等项目创建完成后，进入 `Project Settings` -> `API`。
4. 复制：
   - `Project URL`
   - `anon public` key

## 2. 创建数据表

进入 Supabase 项目的 `SQL Editor`，执行 [supabase/schema.sql](./supabase/schema.sql) 里的 SQL。

这会创建 `marathon_logs` 表，并开启 RLS 安全规则：每个登录用户只能读写自己的训练记录。

## 3. 填入网站配置

打开 [index.html](./index.html)，找到：

```js
const SUPABASE_URL = '';
const SUPABASE_ANON_KEY = '';
```

改成 Supabase 控制台里的值：

```js
const SUPABASE_URL = 'https://你的项目.supabase.co';
const SUPABASE_ANON_KEY = '你的 anon public key';
```

## 4. 配置登录跳转域名

进入 Supabase 项目的 `Authentication` -> `URL Configuration`：

- `Site URL` 填你当前部署的网站域名。
- 如果使用邮箱确认注册，把网站域名也加入 `Redirect URLs`。

## 5. 发布

提交并重新部署网站。打开页面后，登录面板会从“云端同步未配置”变成可登录状态。

未登录时，记录仍存在浏览器本地；登录后，如果云端还没有记录，页面会自动把本地记录迁移到云端。
