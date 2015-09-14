class Compiler < ActiveRecord::Base

  RESERVE = 'reserve'
  OPERAND = 'operand'
  SYMBOL = 'symbol'
  OTHER = 'other'
  RESERVE_WORDS = %w[main #include return define]
  METHODS = %w[if else for do while]
  VARIABLE_TYPES = %w[int float double char string]
  OPERANDS = %w[+ - = * /]
  SYMBOLS = %w[< > ( ) { } ;]


  def validate_words(words)
    words_types = {}
    words.each do |word|
      if RESERVE_WORDS.include? word
        words_types[word] = RESERVE
      elsif  OPERANDS.include? word
        words_types[word] = OPERAND
      elsif SYMBOL.include? word
        words_types[word] = SYMBOL
      else
        words_types[word] = OTHER
      end
    end
    words_types
  end

  def lexical_part
    words_types = self.validate_words(source_code.split(/[ ,;\r\n(><)]+/))
    puts words_types
  end

  def validate_lines(lines)

  end
  def syntactic_part
    lines = self.validate_lines(source_code.split("\n"))
    puts lines
  end
end
