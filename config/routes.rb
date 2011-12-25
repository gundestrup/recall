ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up ''
  # -- just remember to delete public/index.html.
  map.user_change_password 'user/:id/change_password', :controller => 'accounts', :action => 'change_password'
  #map.connect '', :controller => "accounts"
  map.root :controller => 'info'
  map.connect '/sitealizer/:action', :controller => 'sitealizer'

  map.resources :cards
  map.resources :piles
  map.resources :categories

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'
  
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
  map.connect 'sitemap.xml', :controller => "sitemap", :action => "sitemap" 
  map.connect '*path', :controller => 'info', :action => 'error404'


end