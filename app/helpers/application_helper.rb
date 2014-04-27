module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | LaunchU"      
    end
  end
end
