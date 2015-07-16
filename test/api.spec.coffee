# Dependencies
romanizer= require '../src'

# Specs
describe 'romanizer',->
  describe '.romanize',->
    it '日本語でok',(done)->
      japanese= '日本語でok'
      romanized= 'nihongo de ok'

      romanizer.romanize japanese
      .then (romaji)->
        expect(romaji).toBe romanized
        done()

    it 'オウフｗｗｗいわゆるストレートな質問キタコレですねｗｗｗ',(done)->
      japanese= 'オウフｗｗｗいわゆるストレートな質問キタコレですねｗｗｗ'
      romanized= 'ōfu www iwayuru sutorēto na shitsumon kitakore desu ne www'

      romanizer.romanize japanese
      .then (romaji)->
        expect(romaji).toBe romanized
        done()

    it 'The quick brown fox jumps over the lazy dog',(done)->
      english= 'The quick brown fox jumps over the lazy dog'
      romanized= 'The quick brown fox jumps over the lazy dog'

      romanizer.romanize english
      .then (romaji)->
        expect(romaji).toBe romanized
        done()

    it "〔賭博の〕チップを換金する表現パターンcash ［hand, pass］ in one's chips",(done)->
      japanese= "〔賭博の〕チップを換金する表現パターンcash ［hand, pass］ in one's chips"
      romanized= "tobaku no chippu o kankin suru hyōgen patān cash hand pass in one's chips"

      romanizer.romanize japanese
      .then (romaji)->
        expect(romaji).toBe romanized
        done()

    it 'みなさんご存じunknown芋',(done)->
      japanese= 'みなさんご存じunknown芋'
      romanized= 'minasan gozonji unknown imo'

      romanizer.romanize japanese
      .then (romaji)->
        expect(romaji).toBe romanized
        done()
