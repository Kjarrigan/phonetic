#Encoding: UTF-8

require "test/unit"
require "phonetic"

class TestSoundexGer < Test::Unit::TestCase
  include Phonetic
  
  def test_basic
    assert_equal '', soundex_ger('aeijouyäöü')
    assert_equal '', soundex_ger('h')
    assert_equal '1', soundex_ger('b')
    assert_equal '3', soundex_ger('fvw')
    assert_equal '4', soundex_ger('gkq')
    assert_equal '5', soundex_ger('l')
    assert_equal '6', soundex_ger('mn')
    assert_equal '7', soundex_ger('r')
    assert_equal '8', soundex_ger('szß')
  end
  
  def test_rules   
    assert_equal '8', soundex_ger('dcdsdz')
    assert_equal '232323', soundex_ger('dfdvdw')
    
    assert_equal '3', soundex_ger('ph')
    assert_equal '1', soundex_ger('po')

    assert_equal '484848', soundex_ger('cxkxqx')
    assert_equal '748548148', soundex_ger('rxlxbx')
  end
  
  def test_c_rules
    assert_equal '8', soundex_ger('sczc')
    assert_equal '4', soundex_ger('Ch')
    assert_equal '8', soundex_ger('Ci')
    assert_equal '8', soundex_ger('sch')
    assert_equal '4', soundex_ger('ch')
    assert_equal '4', soundex_ger('co')
  end
  
  def test_names
    assert_equal "67", soundex_ger('Meier')
    assert_equal "67", soundex_ger('Maier')
    assert_equal "67", soundex_ger('Mayer')
    assert_equal "67", soundex_ger('Meyer')
    
    assert_equal "47826", soundex_ger('Carsten')
    assert_equal "47826", soundex_ger('Karsten')
    
    assert_equal "17863", soundex_ger('Breschnew')
    assert_equal "65752682", soundex_ger('Müller-Lüdenscheidt')
  end
  
  def test_substeps
    assert_equal "60550750206880022", soundex_ger('Müller-Lüdenscheidt', 0)
    assert_equal "6050750206802", soundex_ger('Müller-Lüdenscheidt', 1)
    assert_equal "65752682", soundex_ger('Müller-Lüdenscheidt', 2)    
  end
end
