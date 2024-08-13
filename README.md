Localizable.xcstrings を翻訳するPerlスクリプトです

翻訳は Google 任せなので translate-shell が必要になります

[**HomeBrew**](https://brew.sh)からインストール

`brew install translate-shell`

このフォルダーに Localizable.xcstrings を置いて下さい

ターミナルで、このフォルダーに入って、以下を実行して下さい

`perl trance.pl 1`

翻訳が終了すると trans.txt に対象文字列が入ってます

`perl trance.pl`

で表示されますので、リダイレクトして下さい

少しのサンプルしかテストしていないので不具合あれば教えて下さい
