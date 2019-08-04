# encoding: utf-8

class ApplicationProcessor

  def handler(arr)

    new_array = []

    for i in arr
      i = i.gsub(/(?<=[0-9])(х)(?=[0-9])/, '*')
      i = i.gsub('x', '*')
      i = i.gsub(/, /, ' ')
      i = i.gsub(/(Провод)(?= )/, '').strip
      i = i.gsub(/(?<=\W)( )(?=ХЛ)/, '-')
      if i.downcase.include?('ту')
        new_array << i.scan(/.+?(?=ТУ)/)[0].split(' ') + i.scan(/(?=ТУ).*\w/)
      else
        new_array << i.split(' ')
      end
    end

    return new_array
  end

  def mapin(things_array, checked)

    for thing in things_array
      if checked.include?(thing)
        return true
      else
        return false
      end

    end

  end

  def final_processing(arr, color, teh)
    to_db = []

    for rows in arr
      row = []

      for col in rows

        if col.downcase.include?('ту') || col.downcase.include?('гост')
          row << { 'тех услов. или гост кабеля' => col }
        elsif col[/\d+[*]\d+/] || col[/\d+[.,]\d+/]
          row << { 'размер' => col }
        elsif mapin(color, col)
          row << { 'исполнение' => col }
        elsif col[/[А-Я]{2,}/] and !mapin(teh, col)
          row << { 'марка' => col }
        elsif col[/[а-я]{3,}/] and !mapin(teh, col)
          row << { 'исполнение' => col }
        else
          row << col
        end

      end

      to_db << row
    end
  return to_db

  end

end
