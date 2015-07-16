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

  normalize: (string)->
    string.replace /[Ａ-Ｚａ-ｚ０-９]/g,(str)->
      String.fromCharCode str.charCodeAt(0) - 65248

  tokenize: (string)->
    @tokenizer.then (tokenizer)->
      tokenizer.tokenize string

  romanize: (string)->
    @tokenize @normalize string
    .then (words)->
      chunks= []
      marked= []

      words.forEach (word)->
        isKatakana= word.surface_form.match(/[ァ-ヶ]/)?
        isEnglish= word.surface_form.match(/[\w]/)?
        isMark= word.surface_form.match(/[']/)

        romanized=
          switch
            when word.reading
              japanese.romanize word.reading

            when isKatakana
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

module.exports= new Romanizer
module.exports.Romanizer= Romanizer