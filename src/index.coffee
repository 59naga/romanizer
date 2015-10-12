# Dependencies
Promise= require 'bluebird'
kuromoji= require 'kuromoji'
japanese= require 'japanese'

path= require 'path'

# Environment
kuromojiRoot= path.dirname require.resolve 'kuromoji/package'
dicPath= (path.join kuromojiRoot,'dist','dict')+path.sep

# Public
class Romanizer
  constructor: ->
    @tokenizer= new Promise (resolve,reject)->
      builder= kuromoji.builder {dicPath}
      builder.build (error,tokenizer)->
        return resolve tokenizer unless error
        return reject error

  # http://d.hatena.ne.jp/Rewish/20100427/1272296260
  normalize: (string)->
    normalized= string.replace /[Ａ-Ｚａ-ｚ０-９！？]/g,(str)->
      String.fromCharCode str.charCodeAt(0) - 65248

    # coffeelint: disable=max_line_length
    specials= {'ｶﾞ':'ガ','ｷﾞ':'ギ','ｸﾞ':'グ','ｹﾞ':'ゲ','ｺﾞ':'ゴ','ｻﾞ':'ザ','ｼﾞ':'ジ','ｽﾞ':'ズ','ｾﾞ':'ゼ','ｿﾞ':'ゾ','ﾀﾞ':'ダ','ﾁﾞ':'ヂ','ﾂﾞ':'ヅ','ﾃﾞ':'デ','ﾄﾞ':'ド','ﾊﾞ':'バ','ﾊﾟ':'パ','ﾋﾞ':'ビ','ﾋﾟ':'ピ','ﾌﾞ':'ブ','ﾌﾟ':'プ','ﾍﾞ':'ベ','ﾍﾟ':'ペ','ﾎﾞ':'ボ','ﾎﾟ':'ポ','ｳﾞ':'ヴ'}
    specialChars= new RegExp '('+(Object.keys specials).join('|')+')','g'
    normalized= normalized.replace specialChars,(str)->
      specials[str]
    # coffeelint: enable=max_line_length

    hankaku= 'ｧｱｨｲｩｳｪｴｫｵｶｷｸｹｺｻｼｽｾｿﾀﾁｯﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓｬﾔｭﾕｮﾖﾗﾘﾙﾚﾛﾜｦﾝｰ'
    zenkaku= 'ァアィイゥウェエォオカキクケコサシスセソタチッツテトナニヌネノハヒフヘホマミムメモャヤュユョヨラリルレロワヲンー'
    normalized= normalized.replace (new RegExp "[#{hankaku}]",'g'),(str)->
      zenkaku[hankaku.indexOf str]

    # Extra ・／… to .
    normalized= normalized.replace /・/g,'.'
    normalized= normalized.replace /…/g,'...'

    # Extra 、／。 to ,.
    normalized= normalized.replace /、/g,','
    normalized= normalized.replace /。/g,'.'

  romanize: (string)->
    normalized= @normalize string

    @tokenize normalized
    .then (words)->
      chunks= []
      marked= []

      words.forEach (word)->
        isHiragana= word.surface_form.match(/[ぁ-ゖ]/)?
        isKatakana= word.surface_form.match(/[ァ-ヶ]/)?
        isEnglish= word.surface_form.match(/[\w]/)?
        isMark= word.surface_form.match(/['!?,.]/)

        romanized=
          switch
            when word.reading
              japanese.romanize word.reading

            when isHiragana or isKatakana
              japanese.romanize word.surface_form

            when isEnglish
              word.surface_form

        # 前回の文字が英語の約物なら連結する
        if isEnglish and marked[chunks.length-1]
          chunks[chunks.length-1]+= word.surface_form
          marked[chunks.length-1]= false
          return

        # 約物は前回の文字に連結する
        if isMark
          chunks[chunks.length-1]+= word.surface_form
          marked[chunks.length-1]= true
          return

        chunks.push romanized if romanized?.trim()

      chunks.join ' '

  tokenize: (string)->
    @tokenizer.then (tokenizer)->
      tokenizer.tokenize string

module.exports= new Romanizer
module.exports.Romanizer= Romanizer
