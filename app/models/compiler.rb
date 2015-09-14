class Compiler < ActiveRecord::Base
  RESERVE = 'reserve'
  OPERAND = 'operand'
  SYMBOL = 'symbol'
  VARIABLE_TYPE = 'variable_type'
  OTHER = 'other'
  RESERVE_WORDS = %w[main #include return define]
  METHODS = %w[if else for do while]
  VARIABLE_TYPES = %w[int float double char string]
  OPERANDS = %w[+ - = * /]
  SYMBOLS = %w[< > ( ) { } ;]


  def validate_words(words)
    words_types = Hash.new
    words.each do |word|
      if RESERVE_WORDS.include? word
        words_types[word] = RESERVE
      elsif  OPERANDS.include? word
        words_types[word] = OPERAND
      elsif SYMBOLS.include? word
        words_types[word] = SYMBOL
      elsif VARIABLE_TYPES.include? word
        words_types[word] = VARIABLE_TYPE
      else
        words_types[word] = OTHER
      end
    end
    words_types
  end

  def lexical_part
    words_types = validate_words(source_code.split(/[ ,;\r\n(><)]+/))
    puts "Words types:"
    puts words_types
  end


  def syntactic_part
    lines = source_code.split(/\r\n/)
    puts lines
    lines.each_with_index do |line, index|
      puts 'error' unless validate_line lines,index
      puts line,index
    end
  end

  def validate_line(line, index)
    #puts line[index]
    words = validate_words line[index].split(/[ ,;\r\n]+/)
    # puts "Words:"
    # puts words
    # puts "Words value in 0:"
    # puts words.values[0]
    if words.keys[0] == "#include"
      puts "going on"
      true if words.keys[1] =~ /<[a-z]*(.h)?>\z/
    end
  end
end
