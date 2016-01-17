module ApplicationHelper
  def have_cards? 
    Card.need_check.count > 0
  end 
end
