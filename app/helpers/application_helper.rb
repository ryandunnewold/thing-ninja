module ApplicationHelper
  def thing_count_class(size)
    case size
      when 0..2
        'low'
      when 3..5
        'medium'
      else 
        'high'
    end 
  end

  def finished_today_string(size)
    if size == 1
      "#{size} thing completed today"
    else
      "#{size} things completed today"
    end
  end
end
