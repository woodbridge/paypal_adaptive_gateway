module ActiveMerchant
  module Billing
    class PaypalAdaptivePaymentGateway < Gateway # :nodoc
      def version
        {:major => 0, :minor => 1, :patchlevel => 3}
      end
    end
  end
  
end