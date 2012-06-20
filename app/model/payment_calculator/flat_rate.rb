class PaymentCalculator::FlatRate < Calculator
  preference :amount, :decimal, :default => 0
  
  # Register the calculator
  def self.register
    super
    PaymentMethod.register_calculator(self)
  end
  
  def self.description
    I18n.t("flat_rate_per_order")
  end

  def compute(object=nil)
    self.preferred_amount
  end
end