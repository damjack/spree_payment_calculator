PaymentMethod.class_eval do
  calculated_adjustments
  
  def self.send_calculator(id = nil)
    if id
      if PaymentMethod.find(id).class.to_s.match(/Gateway/)
        return Gateway.calculators.sort_by(&:name)
      elsif PaymentMethod.find(id).class.to_s.match(/BillingIntegration/)
        return BillingIntegration.calculators.sort_by(&:name)
      else
        return PaymentMethod.calculators.sort_by(&:name)
      end
    else
      return PaymentMethod.calculators.sort_by(&:name)
    end
  end
end