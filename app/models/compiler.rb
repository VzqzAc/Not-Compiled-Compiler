class Compiler < ActiveRecord::Base
  RESERVE = 'reserve'
  OPERAND = 'operand'
  SYMBOL = 'symbol'
  OTHER = 'other'
  RESERVE_WORDS = %w[main include return define if else ]
  OPERANDS = %w[+ - =]
  SYMBOLS = %w[< > ( ) { } ;]


  def validate_words(words)
    words_types = []
    words.each do |word|
      if RESERVE_WORDS.include? word
        words_types << [word,RESERVE]
      elsif  OPERANDS.include? word
        words_types << [word, OPERAND]
      elsif SYMBOLS.include? word
        words_types << [word, SYMBOL]
      else
        words_types << [word,OTHER]
      end
    end
    words_types
  end

  def lexical_part
    words_types = validate_words(source_code.split(/[ ,;\r\n(><)]+/))
    # puts words_types

  end

end
