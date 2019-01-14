class ChargesController < ProtectedController

  impressionist
    
  def new
  end

  def create

    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )


    # Stripe.api_key = "STRIPE_TEST_KEY_REDACTED"
    #
    # plan = Stripe::Plan.create(
    #   nickname: 'Gatrix Monthly Subscription',
    #   product: 'prod_DOsWq3UXM1BWXh',
    #   amount: 1000,
    #   currency: 'usd',
    #   interval: 'month',
    #   usage_type: 'licensed'
    # )
    #
    # subscription = Stripe::Subscription.create(
    #   customer: customer.id,
    #   items:[
    #     {
    #       plan: plan.id,
    #       quantity: 2
    #     }
    #   ]
    # )


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end


end
