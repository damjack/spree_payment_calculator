Spree::Payment.class_eval do
  has_one :adjustment, :as => :source
  before_save :remove_old_adjustment
  after_save :ensure_correct_adjustment, :update_order, :if => Proc.new {|p| !p.payment_method.calculator.blank?}
  
  private
  def remove_old_adjustment
    order.adjustments.each do |adjustment|
      adjustment.destroy if adjustment.source_type == "Payment"
    end
  end
  
  def ensure_correct_adjustment
    if adjustment
      adjustment.originator = payment_method
      adjustment.save
    else
      payment_method.create_adjustment(I18n.t(:payment_adjustment), order, self, true)
      reload #ensure adjustment is present on later saves
    end
  end

  def update_order
    order.update!
  end
end