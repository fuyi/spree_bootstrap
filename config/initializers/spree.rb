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
  get '/t', to: "taxons#top_taxons"
end

# customize searcher, add search for sku
Spree::Core::Search::Base.class_eval do
  def get_products_conditions_for(base_scope, query)
    unless query.blank?
      fields = [:name, :description, :sku]
      values = query.split

      where_str = fields.map{|field|
        if field == :sku
          Array.new(values.size, "spree_variants.sku LIKE ?").join(' OR ') 
        else
          Array.new(values.size, "spree_products.#{field} LIKE ?").join(' OR ') 
        end
      }.join(' OR ')

      base_scope = base_scope.joins(:variants_including_master).where([where_str, values.map{|value| "%#{value}%"} * fields.size].flatten)
    end
    base_scope
  end
end
