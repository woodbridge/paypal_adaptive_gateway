# Paypal Adaptive Payments Library for ActiveMerchant

Supports payments, pre-approvals, refunds and currency conversions

## Install

    gem install paypal_adaptive_gateway

or if you are using Bundler then add the following to your *Gemfile*:

    gem "paypal_adaptive_gateway"

## Use

__Setup your gateway:__

    gateway = ActiveMerchant::Billing::PaypalAdaptivePaymentGateway.new(
     :login => 'your_email',
     :password => 'your_password',
     :signature => ' your_signature',
     :appid => 'your_app_id'
    )

__Payment__

    recipients =
      [
        {:email => 'receiver_email', :amount => some_amount, :primary => true},
        {:email => 'receiver_email', :amount => recipient_amount, :primary => false}
      ]

    gateway.pay(
      :return_url => url_for(:action => 'action', :only_path => false),
      :cancel_url => url_for(:action => 'action', :only_path => false),
      :notify_url => url_for(:action => 'notify_action', :only_path => false),
      :receiver_list => recipients
    )

  The above demonstrates chained payment. Set the _:primary_ flag to _false_ for each
  recipient for parallel payment.  Single recipients are allowed as well.

__Refund__

    recipients =
      [
        {:email => "email_address_0", :amount => <amount_0>} # up to five total recipients
      ]

    gateway.refund(
      :return_url => "returnURL",
      :cancel_url => "cancelURL",
      :pay_key=> "payKey",
      :receiver_list => recipients
    )

__Pre-approved payment__

    gateway.preapprove_payment(
      :return_url => "returnURL",
      :cancel_url => "cancelURL",
      :senderEmail =>"email address of sender",
      :start_date => Time.now,
      :end_date => Time.now + (60*60*24) * 30, # 30 days, cannot be more than a year from the start date
      :currency_code =>"currency code",
      :max_amount => "maxTotalAmountOfAllPayments",
      :maxNumberOfPayments => "maxNumberOfPayments" #optional
    )

__Cancel pre-approved payment__

    gateway.cancel_preapproval(:preapproval_key => "preapprovalkey")

__Debug__

_PaypalAdaptivePaymentGateway#debug_ or _AdaptivePaymentResponse#debug_ return the raw
xml request, raw json response and the URL of the endpoint

