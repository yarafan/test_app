module ApplicationHelper

  def correct_date(str)
    str.to_s.split('-').reverse.join('.')
  end
    
end
