require 'csv'

class Reader

  def read_from_file(file_name)
      return nil if !File.exist?(file_name)

      array = []
      CSV.foreach(file_name, col_sep:';') do |row|
        array << row[0]
      end
      array.shift

      return array
  end
end
