#require 'test_helper'
require File.dirname(__FILE__) + '/test_helper'

class PaypalAdaptivePaymentTest < Test::Unit::TestCase
  def setup
    @gateway = PaypalAdaptivePaymentGateway.new(
       :login => 'platfo_1255077030_biz_api1.gmail.com',
       :password => '1255077037',
       :signature => 'Abg0gYcQyxQvnf2HDJkKtA-p6pqhA1k-KTYE0Gcy1diujFio4io5Vqjf',
       :appid => 'APP-80W284485P519543T'
               )

    @amount = 100

    @receivers = [@amount, 'receiver@example.com']
    
        recipients = [{:email => "platfo_1255612361_per@gmail.com",
                     :amount => 1},
                    {:email => "platfo_1255611349_biz@gmail.com",
                     :amount => 1}
                     ]
    
    @pay_options = {:senderEmail => 'sender@example.com',
                    :remote_ip => '10.0.0.1',
                    :return_url => 'http://example.com/return',
                    :cancel_url => 'http://example.com/cancel',
		    :receiver_list => recipients
		    }

    @paydetails_options = {
	:paykey =>"AP-0UD39701TB886051H"
		    }
			
@preapproval_options = {:return_url => 'http://example.com/return',
        :cancel_url => 'http://example.com/cancel',
	:senderEmail =>'sender@example.com',
	:start_date =>"2011-03-19",
        :end_date =>"2012-02-19",
	:currency_code =>"USD",
	:max_amount =>"100",
	:maxNumberOfPayments =>"10"
	}

    @refund_options_without_ids = {:remote_ip => '10.0.0.1'}

    @refund_options_with_ids = {:tracking_id => '12325231231231',
                                :pay_key => 'AP-13R096665X681474E',
                                :transaction_id => '123123132133',
                                :remote_ip => '10.0.0.1'}

    @pay_key = "AP-2JU68453W94563608"
    @preapproval_key = "PA-13R096665X681474E"
  end

  def test_successful_pay
    assert response = @gateway.pay(@pay_options)
    assert_equal 'Success',"#{response.ack}","Unsuccessfull Transaction"
    assert_equal 'CREATED',"#{response.paymentExecStatus}"
  end
  
 def test_successful_preapproval
	 assert response = @gateway.preapprove_payment(@preapproval_options)
	 assert_equal 'Success',"#{response.ack}","Unsuccessfull Transaction"
 end
 
  def test_successful_paydetails
	 assert response = @gateway.details_for_payment(@paydetails_options)
	 assert_equal 'Success',"#{response.ack}","Unsuccessfull Transaction"
 end
 
  private
  
  def successful_pay_response_json
    <<-RESPONSE
  {"responseEnvelope":{"timestamp":"2009-08-19T20:06:37.422-07:00","ack":"Success","correlationId":"4831666d56952","build":"1011828"},"payKey":"AP-13R096665X681474E","paymentExecStatus":"COMPLETED"}
    RESPONSE
  end

  def successful_payment_details_response_json
    <<-RESPONSE
    {"responseEnvelope":{"timestamp":"2009-08-20T09:37:18.038-07:00","ack":"Success","correlationId":"42e4ea59ba24d","build":"1011828"},"cancelUrl":"http://www.YourCancelURL.com","currencyCode":"USD","logDefaultShippingAddress":"false","paymentInfoList":{"paymentInfo":[{"transactionId":"41X75143SU925680B","transactionStatus":"COMPLETED","receiver":{"amount":"2.00","email":"paymen_1245697080_per@teachstreet.com","primary":"false"},"refundedAmount":"0.00","pendingRefund":"false"}]},"returnUrl":"http://www.YourReturnURL.com","senderEmail":"paymen_1250541923_biz@teachstreet.com","status":"COMPLETED","payKey":"AP-2JU68453W94563608","actionType":"PAY","feesPayer":"EACHRECEIVER","reverseAllParallelPaymentsOnError":"false"}
    RESPONSE
  end

  def successful_preapproval_response_json
    <<-RESPONSE
  {"responseEnvelope":{"timestamp":"2009-08-19T20:06:37.422-07:00","ack":"Success","correlationId":"4831666d56952","build":"1011828"},"preapprovalKey":"PA-13R096665X681474E"}
    RESPONSE
  end

  #TODO - need real result
  def successful_preapproval_details_response_json
    <<-RESPONSE
  {"responseEnvelope":{"timestamp":"2009-08-19T20:06:37.422-07:00","ack":"Success","correlationId":"4831666d56952","build":"1011828"},"preapprovalKey":"PA-13R096665X681474E", "status":"ACTIVE"}
    RESPONSE
  end

  def successful_refund_response_json
    <<-RESPONSE
  {"responseEnvelope":{"timestamp":"2009-08-20T10:41:32.88-07:00","ack":"Success","correlationId":"d7e2312267530","build":"1011828"},"currencyCode":"USD","refundInfoList":{"refundInfo":[{"receiver":{"amount":"1.00","email":"receiver@example.com"},"refundStatus":"NOT_PAID"}]}}
    RESPONSE
  end

  def failed_pay_response_json
    <<-RESPONSE
      {"responseEnvelope":{"timestamp":"2009-08-19T20:07:12.272-07:00","ack":"Failure","correlationId":"fa8f6df75f7c6","build":"1011828"},"error":[{"errorId":"580001","domain":"PLATFORM","severity":"Error","category":"Application","message":"Invalid request: amount cannot be negative"}]}
    RESPONSE
  end
end
