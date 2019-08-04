# encoding: utf-8
current_path = "./" + File.dirname(__FILE__)

require_relative "lib/reader.rb"
require_relative "lib/application_processor.rb"

color = [
  'красный', 'оранжевый', 'желтый', 'зеленый',
  'голубой', 'синий', 'фиолетовый'
]
teh = ['ГОСТ', 'ТУ']

reader = Reader.new
array = reader.read_from_file('data/заявка.csv')
print array
processor = ApplicationProcessor.new
processed_application = processor.handler(array)

to_db = processor.final_processing(processed_application, color, teh)

# print to_db
