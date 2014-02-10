Spree::HomeController.class_eval do
  def contact_us
    render :inline => "test"
  end
end