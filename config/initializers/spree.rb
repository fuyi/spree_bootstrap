# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  config.site_name = "Wai Shing Asian Trading Livs AB"
  config.max_level_in_taxons_menu = 3 # allow 3 levels of taxnomony
  config.show_products_without_price = true # show products without price
end

Spree.user_class = "Spree::User"

#add custom routes
Spree::Core::Engine.routes.prepend do
  # root :to => 'pages#about_us'
  # get '/about_us', :to => 'pages#about_us'
  get '/contact_us', :to => "home#contact_us"
end

# customize searcher
Spree::Core::Search::Base.class_eval do
  def retrieve_products
    'hijacked'
  end
end
