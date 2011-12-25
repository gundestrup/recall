# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def allowed(pile)
    current_user.id == pile.user_id or current_user.admin?
  end


  def sort_td_class_helper(param)
    result = 'class="sortup"' if params[:sort] == param
    result = 'class="sortdown"' if params[:sort] == param + "_reverse"
    return result
  end
  
  def sort_link_helper(text, param)
    key = param
    key += "_reverse" if params[:sort] == param
    options = {
        :url => {:action => 'list', :params => params.merge({:sort => key, :page => nil})},
        :update => 'table',
        :before => "Element.show('spinner')",
        :success => "Element.hide('spinner')"
    }
    html_options = {
      :title => "Sort by this field",
     :href => url_for(:action => 'list', :params => params.merge({:sort => key, :page => nil}))
    }
    link_to_remote(text, options, html_options)
  end

  def tooltip(content, options = {}, html_options = {}, *parameters_for_method_reference)
      html_options[:title] = options[:tooltip]
      html_options[:class] = html_options[:class] || 'tooltip'
      content_tag("span", content, html_options)
  end

  def breadcrum(name,controller,id)
       link_to name, :controller => controller, :action => 'show', :id => id
  end

end
