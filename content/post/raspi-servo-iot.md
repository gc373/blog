---
title: "【Node.js】#RaspberryPi でサーボを使って超お手軽 #IoT"
date: 2019-03-30T17:57:35+09:00
draft: false
toc: true
eyecatch: "img/kilroy.jpg"
tags: ["iot", "Programming"]
description: ""
---
こんにちは、こんにちは みなみです  
今回はラズパイでお手軽IoTをやっていきます  
つかうのはNode.jsとサーボです(日本語記事が少なかったので)  
<!--more-->
<!-- TOC -->
# TL;DR
---
- [0. 必要なもの](#0.-必要なもの)
- [1. RaspberryPiの設定](#1-raspberrypiの設定)
- [2. サーボの準備](#2-サーボの準備)
- [3. Node.jsの設定](#3-nodejsの設定)
- [4. 動作確認](#4-動作確認)
- [5. サーバで待受して遠隔操作してみる](#5-サーバで待受して遠隔操作してみる)

---
<!-- /TOC -->

# 0. 必要なもの
---
- Raspberry Pi(今回の記事ではRaspberry Pi 3を使用しましたが、WやWHでも動作可能です)
- サーボ [SG90](http://akizukidenshi.com/catalog/g/gM-08761/)
- ジャンプワイヤー(ラズパイとの接続に必要です)
- ラズパイの基本物
  - SDカード
  - microUSBの充電ケーブル
  - _必要であればHDMIケーブルやUSBキーボードなど_
- その他
  - _壁やリモコンにくっつけるための両面テープ_  
  (僕は100均の強力アクリルテープでくっつけました)

# 1. RaspberryPiの設定
---
まず、初期セットアップを済ませてSSHで接続できるようにします  
このへんを参考にしてみてください  
[Raspberry Pi 初期設定](https://qiita.com/HeRo/items/c1c30d7267faeb304538)  
また、SDカードに書き込む際にWi-Fiの設定をしておくと、画面無しでもSSHまで一気にいけます  
[Raspberry Piの無線LANをmicroSDで設定する](https://qiita.com/mascii/items/0d1a280ac58ed8f6f999)  

僕の場合はVSCodeの拡張機能を使い、遠隔エディタとして作業しました  
VSCodeでSSH FSという拡張機能をつかうとSSH先をVSCodeで表示しながら作業できるため、非常に便利です  
[Visual Studio CodeでSSHごしにファイルを編集する](https://qiita.com/informationsea/items/5c9f05c81a41fb885460)


# 2. サーボの準備
---
Raspberry Piと  
- GND  
- 5V  
- **18番**  
をジャンプワイヤーでつなぎます  
<img src="/img/breadboard_raspi_servo.png" width="100%">

# 3. Node.jsの設定
---
Raspberry PiにはNode.jsが入ってると思いますが念の為  
``` bash
$ node --version
v11.10.0
```
これでOKです  
npmをつかって必要なモジュールをインストールします  
今回つかうのはこちらです  
[pigpio](https://www.npmjs.com/package/pigpio)  
これをnpmでインストールします
``` bash
$ npm init # 適当なプロジェクト名をつけておきます
$ npm i pigpio
```

# 4. 動作確認
---
簡単なサンプルを用意したので動作確認をしてみます
```js
const pigpio = require("pigpio");
const Gpio = pigpio.Gpio;
const servoPinNo = 18; // 今回はGPIOの18番をつかいます
const motor = new Gpio(servoPinNo, { mode: Gpio.OUTPUT });

// この関数はキープしておくと便利です
function sleep(sec) {
  return new Promise(resolve => setTimeout(resolve, sec * 1000));
}

// const PALSMAX = 2500;
// const PALSMIN = 500;
let start;

async function switchOnOff() {
  await motor.servoWrite(1600);
  await sleep(0.3);
  await motor.servoWrite(1950);
  await sleep(0.1);
  await motor.servoWrite(1600);
  console.log(`switch pushed!! ${new Date().toLocaleString()}`);
}
(async () => {
	await switchOnOff();
})()
```
これを `servo.js` という名前をつけて保存します
``` bash
$ sudo node servo.js # piユーザーの場合はsudo必須です
```
これでサーボが動けば大丈夫です  
(クイックイッと動くはずです)

# 5. サーバで待受して遠隔操作してみる
---
今回は壁に貼り付けて電気スイッチを押してもらうことにしました  
htmlファイルをおいて、expressでサーバを立てます  
こういった階層になります  
``` bash
|--gpio.js
|--main.js
|--public
|  |--index.html
|--router.js
|--wakeup.json
```
**[リポジトリはこちら](https://github.com/gc373/simply-switch-on-off)**  

もう少し簡単にまとめることもできますが、今回はルーティングの動作確認も含めてファイルを分割しました  
``` bash
$ node main
```
でサーバ起動し、Raspberry PiのIPアドレスをブラウザで開くと画面が表示されます  
もちろん、スマホからでも動作します  
家のネットワーク内なら遠隔で電気を点けることができるようになりました  
_wakeup.jsonはpm2での永続化のためにつくりましたので、実際の起動は `pm2 start ./wakeup.json` となります_  
実際の動作はこんな感じです  
{{< youtube iuFKq4MNQl8 >}} 

# 6. 後記
---
このサーボではトルクが弱いので鍵の開け締めは難しいですが、サーボを交換すればスマートロックにも使えます  
もちろんその際は認証まわりをきちんと設定してください  
_グローバルIPでなければそもそもネットワークに接続した端末でしか操作できないですが_  

たとえばグローバルIPがない場合でも、EC2インスタンスをつかってWebSocketサーバを立ててローカルから接続させたり、  
hubotを使ってSNSやSlackから操作したりすることで外出先からの操作も考えられます  
もちろんGoogle HomeやAmazon Echoと連携することもできます  
まずは今回のようなお手軽おうちハックからはじめて、徐々に使い勝手を上げていくとよいでしょう

それでは