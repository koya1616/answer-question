module ApplicationHelper
   
   def full_title(title)
    base_title = 'EXACTLY'
    if title.blank?
      base_title
    else
      "#{title} | #{base_title}"
    end
   end
  
   def resource_name
      :user
   end
   
   def resource
      @resource ||= User.new
   end
   
   def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
   end
end
