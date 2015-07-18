# ローマナイザー [![NPM version][npm-image]][npm] [![Build Status][travis-image]][travis] [![Coverage Status][coveralls-image]][coveralls]

## Installation

```bash
$ npm install romanizer --save
```

# API

## .romanize(japanese) -> Promise(romanized)

引数の日本語をローマ字に変換して返します。

```js
var romanizer= require('romanizer');

romanizer.romanize('日本語でok')
.then(function(romaji) {
  console.log(romaji);// nihongo de ok
});

romanizer.romanize('オウフｗｗｗいわゆるストレートな質問キタコレですねｗｗｗ')
.then(function(romaji) {
  console.log(romaji);// ōfu www iwayuru sutorēto na shitsumon kitakore desu newww'
});

romanizer.romanize('The quick brown fox jumps over the lazy dog')
.then(function(romaji) {
  console.log(romaji);// The quick brown fox jumps over the lazy dog
});

romanizer.romanize("〔賭博の〕チップを換金する表現パターンcash ［hand, pass］ in one's chips")
.then(function(romaji) {
  console.log(romaji);// tobaku no chippu o kankin suru hyōgen patān cash hand,pass in one's chips
});

romanizer.romanize('みなさんご存じunknown芋')
.then(function(romaji) {
  console.log(romaji);// minasan gozonji unknown imo
});

romanizer.romanize('何だと思う？これね、ミキプルーンの苗木。')
.then(function(romaji) {
  console.log(romaji);// nani da to omō? kore ne, mikipurūn no naegi.
});

romanizer.romanize('たっぷんたっぷんすればいいんじゃね')
.then(function(romaji) {
  console.log(romaji);// ta' puntappunsurebaiinjane
});

romanizer.romanize('エターナルフォースブリザード')
.then(function(romaji) {
  console.log(romaji);// etānarufōsuburizādo
});
```

# 課題

* 半角カナには対応していません。

# Related projects
* __romanizer__
* [kuromoji.js](https://github.com/takuyaa/kuromoji.js)
* [japanese.js](https://github.com/hakatashi/japanese.js)

License
---
[MIT][License]

[License]: http://59naga.mit-license.org/

[sauce-image]: http://soysauce.berabou.me/u/59798/romanizer.svg
[sauce]: https://saucelabs.com/u/59798
[npm-image]:https://img.shields.io/npm/v/romanizer.svg?style=flat-square
[npm]: https://npmjs.org/package/romanizer
[travis-image]: http://img.shields.io/travis/59naga/romanizer.svg?style=flat-square
[travis]: https://travis-ci.org/59naga/romanizer
[coveralls-image]: http://img.shields.io/coveralls/59naga/romanizer.svg?style=flat-square
[coveralls]: https://coveralls.io/r/59naga/romanizer?branch=master
