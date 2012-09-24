# Encoding: UTF-8
######################################################
# Kölner Phonetik. modified soundex algorithm for german words
######################################################

module Phonetic
  SxgRule = Struct.new :number, :conditions, :alternative
  class NoRuleGiven < RuntimeError; end
  
  # modified soundex for german language ->  Kölner Phonetik
  # 1) letter -> code, Bsp. Müller-Lüdenscheidt -> 60550750206880022
  # 2) remove pairs, Bsp. 6050750206802
  # 3) remove 0 (except first letter), Bsp. 65752682
  GerSound = {
    'a'=> SxgRule.new(0, {}),
    'e'=> SxgRule.new(0, {}),
    'i'=> SxgRule.new(0, {}),
    'j'=> SxgRule.new(0, {}),
    'y'=> SxgRule.new(0, {}),
    'o'=> SxgRule.new(0, {}),
    'u'=> SxgRule.new(0, {}),
    'ä'=> SxgRule.new(0, {}),
    'Ä'=> SxgRule.new(0, {}),
    'ö'=> SxgRule.new(0, {}),
    'Ö'=> SxgRule.new(0, {}),
    'ü'=> SxgRule.new(0, {}),
    'Ü'=> SxgRule.new(0, {}),
    'b'=> SxgRule.new(1, {}),
    'p'=> SxgRule.new(3, {:prior => ['h']}, 1),
    'd'=> SxgRule.new(8, {:prior => ['c', 's', 'z']}, 2),
    't'=> SxgRule.new(8, {:prior => ['c', 's', 'z']}, 2),
    'f'=> SxgRule.new(3, {}),
    'v'=> SxgRule.new(3, {}),
    'w'=> SxgRule.new(3, {}),
    'g'=> SxgRule.new(4, {}),
    'k'=> SxgRule.new(4, {}),
    'q'=> SxgRule.new(4, {}),
    'c'=> SxgRule.new(4, {:first_letter_prior => %w{a h k l o q r u x}, :prior => %w{a h k o q u x}, :except_after => ['s', 'z']}, 8),
    'x'=> SxgRule.new(48, {:after => ['c','k','q']}, 8),
    'l'=> SxgRule.new(5, {}),
    'm'=> SxgRule.new(6, {}),
    'n'=> SxgRule.new(6, {}),
    'r'=> SxgRule.new(7, {}),
    's'=> SxgRule.new(8, {}),
    'z'=> SxgRule.new(8, {}),
    'h' => SxgRule.new('', {}),
    'ß' => SxgRule.new(8, {}),
    '-' => SxgRule.new('', {})
  }
  
  # Create the soundex Code for the given Word
  # The optional params allows to get the result
  # of an previous step. Mainly for test-reasons
  def soundex_ger(word, level=2)
    word = word.downcase
    sdx_result = ''
    word.split('').each_with_index do |char, idx|
      rule = GerSound[char]
      raise NoRuleGiven, "No rule defined (or encoding wrong) for #{char.inspect}!" unless rule
            
      unless rule.conditions.empty?
        if idx == 0 and rule.conditions[:first_letter_prior]
          sdx_result << (rule.conditions[:first_letter_prior].include?(word[1]) ? rule.number : rule.alternative).to_s
        end
        
        if rule.conditions[:after]
          sdx_result << (rule.conditions[:after].include?(word[idx-1,1]) ? rule.alternative : rule.number).to_s 
          next
        end
        
        if rule.conditions[:prior]
          if rule.conditions[:prior].include?(word[idx+1,1])
            if rule.conditions[:except_after]
              sdx_result << (rule.conditions[:except_after].include?(word[idx-1,1]) ? rule.alternative :  rule.number).to_s 
            else
              sdx_result << rule.number.to_s
            end
          else
            sdx_result << rule.alternative.to_s
          end
          next
        end
      else
        sdx_result << rule.number.to_s
      end
    end
    
    return sdx_result if level == 0
    return sdx_result.squeeze if level == 1
    return sdx_result.squeeze.gsub('0', '') # Doppelte und 0en raus
  end
end
