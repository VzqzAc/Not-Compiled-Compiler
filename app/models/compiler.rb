class Compiler < ActiveRecord::Base
  RESERVE = 'reserve'
  OPERAND = 'operand'
  SYMBOL = 'symbol'
  OTHER = 'other'
  VARIABLE = 'variable'
  RESERVE_WORDS = %w[main #include return define]
  METHODS = %w[if else for do while]
  VARIABLE_TYPES = %w[int float double char string]
  OPERANDS = %w[+ - = * /]
  SYMBOLS = %w[< > ( ) { } ;]
  INCLUDE = '#include'


  def validate_words(words)
    words_types = []
    words.split(/[ ,\r\n(><)]+/).each do |word|
      if RESERVE_WORDS.include? word
        words_types << [word,RESERVE]
      elsif  OPERANDS.include? word
        words_types << [word,OPERAND]
      elsif SYMBOLS.include? word
        words_types << [word, SYMBOL]
      elsif VARIABLE_TYPES.include? word
        words_types << [word,VARIABLE]
      else
        if word.slice(";").nil?
          words_types << [word,OTHER]
        else
          words_types << [word,OTHER]
          words_types << [";",SYMBOL]
        end
      end
    end
    words_types
  end

  def lexical_part

    words_types = validate_words(source_code)
    # puts words_types

    puts "Words types:"
    puts words_types

  end

  def validate_line(lines,index)
    return if lines[index].empty?
    line = lines[index].gsub( "\n" , "")
    words = validate_words line
    first_word = words[0][1]

    if first_word == VARIABLE
      puts 'Varible asignation' if variable_allocation words
    elsif words[0][0] == INCLUDE
      puts 'Inlcude added' if line =~ /<[a-z]*(.h)?>\z/
    end

  end

  def syntactic_part
    lines = source_code.split(/\n?\r/)
    lines.each_with_index  do |line,index|
      validate_line lines,index
    end
    lines
  end


  def variable_allocation(words)
    can_finish = false
    valid = true
    words.each do |word|
      case word[1]
        when VARIABLE
          can_finish = false
          puts 'variable'
        when OTHER
          can_finish = true
          puts 'other'
        when OPERAND
          can_finish = false
          puts 'operna'
        else
          puts 'error'
          can_finish = false
      end
    end
    can_finish
  end

end
