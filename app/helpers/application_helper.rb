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
end
