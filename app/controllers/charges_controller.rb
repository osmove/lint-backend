class ChargesController < ProtectedController

  impressionist

  def new
  end

  def create

    # Amount in cents
    # @amount = 500

    @message = "Error"

    @customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    # charge = Stripe::Charge.create(
    #   :customer    => @customer.id,
    #   :amount      => @amount,
    #   :description => 'Omnilint Customer',
    #   :currency    => 'usd'
    # )

    @subscription = Stripe::Subscription.create(
      customer: @customer.id,
      items:[
        {
          plan: 'developer_monthly',
          quantity: 1
        }
      ]
    )


    # if @customer.present? && @customer.id.present? && @subscription.present? && @subscription.id.present?
    if @customer.present? && @customer.id.present? && @subscription.present? && @subscription.id.present?

      @user = User.where(stripe_customer_id: @customer.id).first rescue nil
      if(@user.present?)
        @message = "User found: #{@user.username}"
      else
        @user = User.where(email: @customer.email).first rescue nil
        if @user.present? && @user.stripe_customer_id.blank?
          @user.stripe_customer_id = @customer.id
          @user.save
        end
      end

      if(@user.present?)
        @current_plan = @user.plan
        # @new_plan_nickname = @subscription.plan.nickname.downcase rescue nil
        @stripe_product_id = @subscription.plan.product
        if @stripe_product_id.present?
          @new_plan = Plan.where(stripe_product_id: @stripe_product_id).first rescue nil
          if @new_plan.present?
            @user.plan = @new_plan
            @user.save
            @message = "Plan successfully updated from: #{@current_plan} to #{@current_plan}"
            # redirect_to plans_path
          else
            @message = "Error: No Plan Found"
          end
        else
          @message = "Error: Missing Stripe Product Id"
        end
      else
        @message = "Error: No User Found"
      end
    else
      @message = "Error: Wrong Stripe Data"
    end

    # flash[:error] = @message
    # redirect_to plans_path


    # Stripe.api_key = "STRIPE_TEST_KEY_REDACTED"
    #
    # plan = Stripe::Plan.create(
    #   nickname: 'Omnilint Monthly Subscription',
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
    # @message = e.message
    redirect_to plans_path
    # redirect_to new_charge_path
  end


end
