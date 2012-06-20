module Spree
  module Core
    class Environment
      class Calculators
        include EnvironmentExtension

        attr_accessor :shipping_methods, :tax_rates, :payment_methods
      end
    end
  end
end