class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @plan = params[:plan]
  end

  def create
    plan = params[:plan]
    token = params[:stripeToken]

    
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

    begin
      
      customer = Stripe::Customer.create(
        source: token,
        email: current_user.email
      )

     
      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: plan_amount(plan),
        description: "#{plan.capitalize} Plan",
        currency: 'usd'
      )

     
      if charge.paid
       
        current_user.update(premium: true) 
        redirect_to root_path, notice: "Thank you for purchasing the #{plan.capitalize} Plan!"
      else
        flash[:alert] = "Payment failed. Please try again."
        render :new
      end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_payment_path(plan: plan)
    end
  end

  private

  # Determines the amount to charge based on the selected plan
  def plan_amount(plan)
    case plan
    when 'basic'
      999  # $9.99
    when 'silver'
      1999 # $19.99
    when 'diamond'
      2999 # $29.99
    else
      flash[:alert] = "Invalid plan selected."
      redirect_to new_payment_path
    end
  end
end
