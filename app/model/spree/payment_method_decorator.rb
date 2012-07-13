Spree::PaymentMethod.class_eval do
  calculated_adjustments
  
  def self.send_calculator(id = nil)
    if id
      if Spree::PaymentMethod.find(id).class.to_s.match(/Gateway/)
        return Spree::Gateway.calculators.sort_by(&:name)
      elsif Spree::PaymentMethod.find(id).class.to_s.match(/BillingIntegration/)
        return Spree::BillingIntegration.calculators.sort_by(&:name)
      else
        return Spree::PaymentMethod.calculators.sort_by(&:name)
      end
    else
      return Spree::PaymentMethod.calculators.sort_by(&:name)
    end
  end
end