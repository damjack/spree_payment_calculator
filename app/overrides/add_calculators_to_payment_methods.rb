Deface::Override.new(:virtual_path => 'admin/payment_methods/_form',
                     :name => 'add_calculators_to_payment_methods',
                     :insert_before => %q{[id='preference-settings']}, 
                     :text => %q{<% @calculators = PaymentMethod.calculators.sort_by(&:name) rescue nil %><%= render :partial => 'admin/shared/calculator_fields', :locals => {:f => f}},
                     :disabled => false)