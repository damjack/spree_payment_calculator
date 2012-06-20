module SpreePaymentCalculator
  class Engine < Rails::Engine
    engine_name 'spree_payment_calculator'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/overrides/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      
      Dir.glob(File.join(File.dirname(__FILE__), "../../lib/spree/environment/calculator.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end
    initializer 'spree.register.calculators' do |app|
      app.config.spree.calculators.payment_methods = [
        PaymentCalculator::PriceSack,
        PaymentCalculator::FlatPercentItemTotal,
        PaymentCalculator::FlatRate,
        PaymentCalculator::FlexiRate,
        PaymentCalculator::PerItem
      ]
    end

    config.to_prepare &method(:activate).to_proc
  end
end
