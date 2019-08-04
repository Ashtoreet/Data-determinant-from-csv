require 'test/unit'
require_relative "lib/reader.rb"
require_relative "lib/application_processor.rb"


class TestProgram < Test::Unit::TestCase

  def test_read_from_file_getting_an_array
    # getting an array from a file

    file_name = 'data/заявка.csv'
    reader = Reader.new
    expected = reader.read_from_file(file_name)
    assert_equal expected.class, Array
  end

  def test_read_from_file
    # reading a nonexistent file returns nil

    file_name = 'data/заявк.csv'
    reader = Reader.new
    expected = reader.read_from_file(file_name)
    assert_equal expected, nil
  end

  def test_handler
    # array does not contain x(ru)

    array = [
      "ПЭТД-180 1x0,28"
    ]

    processor = ApplicationProcessor.new
    # processed_application = processor.handler(array)

    processed_application = processor.handler(array)
    expected = processed_application[0].include?('x')
    assert_equal expected, false
  end

  def test_handler_2
    # array does not contain x

    array = [
      "ПЭТД-180 1x0,28"
    ]

    processor = ApplicationProcessor.new

    processed_application = processor.handler(array)
    expected = processed_application[0].include?('х')
    assert_equal expected, false
  end

  def test_handler_3
    # array does not contain Провод

    array = [
      "Провод ПЭТВ-2 0,950 ТУ 16-705-110-79"
    ]

    processor = ApplicationProcessor.new

    processed_application = processor.handler(array)
    expected = processed_application[0].include?('Провод')
    assert_equal expected, false
  end

  def test_mapin
    # part of the string is contained in this array
    things_array = ['a', 'b', 'c']
    checked = 'a'

    processor = ApplicationProcessor.new

    expected = processor.mapin(things_array, checked)
    assert_equal expected, true
  end

  def test_mapin_2
    # part of the string is contained in this array
    things_array = ['a', 'b', 'c']
    checked = 'a h'

    processor = ApplicationProcessor.new

    expected = processor.mapin(things_array, checked)
    assert_equal expected, true
  end

  def test_final_processing_is_hash_array
    # the result is an hash array

    color = [
      'красный', 'оранжевый', 'желтый', 'зеленый',
      'голубой', 'синий', 'фиолетовый'
    ]
    teh = ['ГОСТ', 'ТУ']

    reader = Reader.new
    array = reader.read_from_file('data/заявка.csv')

    processor = ApplicationProcessor.new
    processed_application = processor.handler(array)

    expected = processor.final_processing(processed_application, color, teh)

    assert_equal expected[0][0].class, Hash
  end
end