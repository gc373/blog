---
title: "暇だったからslackinを日本語化した"
date: 2017-12-28T02:25:02+09:00
draft: false
toc: true
eyecatch: "/img/invite_slack.png"
tags: ["Programming","Slack"]
---
はい、Slackの自動招待メールを受け取るslackinの話。  
<!--more-->

![](/img/invite_slack.png)
# 目次

---
<!-- TOC -->
- [目次](#目次)
- [Slack...?](#slack)
- [slackin...?](#slackin)
- [日本語化](#日本語化)
- [つかおうSlack](#つかおうslack)

<!-- /TOC -->
---

# Slack...?
---
[Slack](https://slack.com/intl/ja-jp)つかってますか？  
なにそれ？って方はぐぐってもらうとして、  
簡単に言うとチャットアプリです。  
最近日本語化してエンジニア以外でも使いやすくなりましたね(フォントがくそですが)  
通話もできるし、メールアドレスだけで登録できるし、  
人数制限もなく、無料でずっとつかえます。  

無料で運用する場合、1万件を超えるとメッセージが消えていきますが、  
それ以外は特に困ることはないです。  

# slackin...?
---
Slackは通常、メンバーから招待してもらうことで参加できます。  
ただ、毎回毎回メンバーにお願いをするのも面倒です。  
そこで自動で招待メールを送ることができるシステムが[slackin](https://github.com/rauchg/slackin)です。  
herokuという無料のアプリ公開サービスを使うと、簡単に自動招待メールを送るシステムを構築できます。  

[slackin](https://github.com/rauchg/slackin)のトップページにも、  
![](/img/slackin_platforms.png)  
とあるように、いくつかのプラットフォームへデプロイが可能です。  

# 日本語化
---
ただ、slackinはすべて英語のため、  
たとえメールアドレスを入れて招待メールを受け取るだけでも  
避けられてしまうかもしれません。  

そこで、さくっと日本語化してしまいましょう。  
触るのは1ファイルだけ、つかうGitコマンドも次の5つです。

- git clone
- git checkout -b [ブランチ名]
- git add .
- git commit -m "コミットメッセージ"
- git push

**! ちゃんと自分のリポジトリにフォークしてから、**  
**自分のリポジトリにpushしましょう！！！(ミスった)**  

実際の変更箇所は *slackin/lib/splash.js* です。  
差分を見てもらうとして、  
![diff](/img/slackin_diff.png)  
[diff](https://github.com/gc373/slackin/commit/7582c402a78f63798c9b41e91c2e84236b5b5c31)  
全然難しくないですね。そんな感じです。  
あとはMasterにマージして、herokuにデプロイしてあげたら日本語化完了！

# つかおうSlack
---
本家Slackが日本語化されたこともあり、  
どんどんエンジニア以外にも広まるといいなと思っています。  
さらに気軽に参加できるよう、招待も日本語で、  
自動化されたものを使うとよいかな、と。  
いくらでもチームがつくれるので、趣味に合わせて使い分けたいですね。  

というここまでの話で、  
アイドルのdotstokyoに関わることを共有するためのSlackチームあります！  
[こちらからどうぞ](https://invite2dots.herokuapp.com)  
気軽に参加して、気軽に話しかけてみてください。  

では。