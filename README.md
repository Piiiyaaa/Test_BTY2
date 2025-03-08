## ■ サービス概要
「昨日の自分より少しだけ成長する」をコンセプトに、日々の小さな学びを記録し、それをシェアできるSNS。<br>
また、日々の投稿には「今日の一問」という問題もあわせて作成できる。<br>
過去の自分が作った問題に挑戦することで、知識の定着と自分の成長をサポートする。

## ■ このサービスへの思い・作りたい理由
学習において最も重要なのは、学びを継続することである。しかし多くの場合、時間の都合やモチベーションが原因で継続が途切れてしまう。<br>
実際、RUNTEQで勉強していても、同期のなかで姿を見なくなってしまった人がいる。<br>
学習の継続で大事だと思うことが2点ある。それが、「コミュニティ」と「成長の実感」だ。<br>
過去の自分より少しずつ賢くなることで、モチベーションの維持とスキルアップを促す。<br>
また学んだことをシェアし、互いに「いいね」しあうことで、学習の離脱を防げるのではないかと考えた。

## ■ ユーザー層について
高校生・大学生・専門学生や20〜30代の成長意欲のある社会人など、継続的に学習をする必要がある人/したい人

## ■サービスの利用イメージ
このサービスでは、ユーザーが日々の学びを記録し、学んだことをもとに作問して解くことを継続することで知識の定着と成長をサポートする。<br>
さらに、フォロー機能を通じて、他のユーザーと学びを共有したり、励まし合ったりすることができる。これにより、学習からの離脱を図る。<br>
### 【ログイン前】
下記が利用可能
<ul>
  <li>投稿一覧の閲覧</li>
  <li>タグ検索による絞り込み</li>
  <li>ユーザーのマイページ閲覧</li>
</ul>

### 【ログイン後】
ログイン前の機能に加えて、下記が利用可能
<ul>
  <li>今日の学びの投稿機能</li>
  <li>いいね機能</li>
  <li>フォロー機能</li>
  <li>コメント機能</li>
  <li>「今日の一問」への解答機能</li>
  <li>自分のマイページ閲覧</li>
</ul>

### 機能詳細
◇学びの記録を投稿できる
<ul>
  <li>タイトルと学んだことを400字以内で記録</li>
  <li>カテゴリタグを設定できる</li>
  <li>Web上の記事や動画教材で学習した人向けにURLも添付できる</li>
  <li>ノートやスクショなどの画像も添付できる</li>
  <li>記述式・選択式・穴埋め式のテンプレートを使って「今日の一問」を作成（Open AIのAPIを使って自動作問も実装予定）</li>
  <li>今日の一問の解答は自分でタイピングして作成（AIは使わない）</li>
</ul>

◇「今日の一問」への解答機能
<ul>
  <li>学びの記録で作成した「今日の一問」をチェックできる</li>
  <li>一覧画面では学習した日付とタイトル、学んだことが表示される</li>
  <li>詳細画面を開くと「今日の一問」と回答が表示される（回答はトグルで隠されている状態）</li>
  <li>セルフチェックをして「正解」と「不正解」のボタンをクリックする</li>
  <li>正解率が記録されマイページに表示される</li>
</ul>

## ■ ユーザーの獲得について
Xで宣伝を行う。MatterMostを使ってRUNTEQ生にも周知する。

## ■ サービスの差別化ポイント・推しポイント
  【類似サービス】  
instagram,XなどのSNS  
Notionなどのメモアプリ

◇3つの差別化ポイント
<ul>
  <li>他の学習記録アプリやSNSにはない「今日の一問」という機能</li>
  <li>同じ分野の学習者とつながり、学んだことの整理方法や学び方をシェアできること</li>
  <li>過去の自分より成長したことが可視化できること</li>
</ul>

## ■ 機能候補　
【MVPリリース】
<ul>
  <li>マイページ機能（自分の学習記録一覧、プロフィール編集）</li>
  <li>ログイン機能（Deviseを使用）</li>
  <li>学びの記録投稿機能（タイトル、本文、カテゴリタグ、URL、画像アップロード）</li>
  <li>学びの記録一覧表示（Twitter風のUI）</li>
  <li>学びの記録の編集・削除機能</li>
  <li>「今日の一問」手動作成機能（ユーザーが自分で問題を作成）</li>
  <li>画像アップロード機能（Active Storage + AWS S3）</li>
</ul>

【本リリース】
<ul>
  <li>「今日の一問」AI自動作問機能</li>
  <li>タグ絞り込み機能</li>
  <li>フォロー機能</li>
  <li>いいね機能</li>
  <li>過去の自分に勝った！パーセンテージ表示</li>
  <li>利用規約・プライバシーポリシー</li>
</ul>
  
## ■ 機能の実装方針予定
実装経験のないものは技術検証していく予定
<ul>
  <li>ログイン機能（devise）</li>
  <li>投稿絞り込み機能(form object)</li>
  <li>画像アップロード機能（Active Storage + AWS S3）</li>
  <li>Xシェア機能（gem meta-tags,mini_magick,）</li>
  <li>利用規約・プライバシーポリシー（gem 'high_voltage'）</li>
  <li>「今日の一問」AI自動作問機能（OpenAI API）</li>
  <li>過去の自分に勝った！パーセンテージ表示機能（Chartkick）
</ul>

## ■ 画面遷移図
https://www.figma.com/design/E020i7jejLbLBX5zsJlKG4/Better-Than-Yesterday?node-id=0-1&t=HEx6TgI5jYq8eErI-1

## ■ ER図
[![Image from Gyazo](https://i.gyazo.com/06d03805616659da2c43ea31a4035d5c.png)](https://gyazo.com/06d03805616659da2c43ea31a4035d5c)