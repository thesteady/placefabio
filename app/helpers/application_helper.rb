module ApplicationHelper
  def body_class
    [controller_name.gsub('_','-'), action_name.gsub('_','-')].join('-')
  end
end
