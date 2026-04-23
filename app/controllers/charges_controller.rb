class ChargesController < ProtectedController

  impressionist

  def new
  end

  def create

    # Amount in cents
    # @amount = 500

    @message = "Error"

    # @customer = Stripe::Customer.create(
    #   :email => params[:stripeEmail],
    #   :source  => params[:stripeToken]
    # )

    # charge = Stripe::Charge.create(
    #   :customer    => @customer.id,
    #   :amount      => @amount,
    #   :description => 'Lint Customer',
    #   :currency    => 'usd'
    # )

    # @subscription = Stripe::Subscription.create(
    #   customer: @customer.id,
    #   items:[
    #     {
    #       plan: 'developer_monthly',
    #       quantity: 1
    #     }
    #   ]
    # )


    # if @customer.present? && @customer.id.present? && @subscription.present? && @subscription.id.present?
    puts "$$$ Stripe: Create charge 1"
    if params[:stripeEmail].present?
      puts "$$$ Stripe: Create charge 2"

      # Find user by Stripe Customer Id
      @user = User.where(email: params[:stripeEmail]).first rescue nil
      if(@user.present?)
        @message = "User found: #{@user.username}"
        puts @message
        if @user.stripe_customer_id.present?
          @customer = Stripe::Customer.retrieve(@user.stripe_customer_id) rescue nil
          if @customer.blank?
            puts "$$$ Stripe: Create charge 3"
            @customer = Stripe::Customer.create(
              :email => params[:stripeEmail],
              :source  => params[:stripeToken]
            )
            if @customer.id.present?
              puts "$$$ Stripe: Create charge 3"
              puts @customer.id
              @user.stripe_customer_id = @customer.id
              @user.save
            end
          end
        else
          puts "$$$ Stripe: Create charge 4"
          @customer = Stripe::Customer.create(
            :email => params[:stripeEmail],
            :source  => params[:stripeToken]
          )
          puts "$$$ Stripe: Create charge 5"
          if @customer.id.present?
            puts "$$$ Stripe: Create charge 6"
            puts @customer.id
            @user.stripe_customer_id = @customer.id
            @user.save
          end
        end
      else
        puts "$$$ Stripe: Create charge 7"
        @message = "Error: Impossible to create Stripe Customer"
      end

      puts "$$$ Stripe: Create charge 8"
      if(@user.present?)
        puts "$$$ Stripe: Create charge 9"
        @current_plan = @user.plan
        @subscription = Stripe::Subscription.create(
          customer: @customer.id,
          items:[
            {
              plan: params['stripe_plan_id'],
              quantity: params['number_of_seats']
            }
          ]
        )
        puts "$$$ Stripe: Create charge 10"

        if(@subscription.present?)
          puts "$$$ Stripe: Create charge 11"
          # TODO: Cancel current subsription
          # @new_plan_nickname = @subscription.plan.nickname.downcase rescue nil
          @stripe_product_id = @subscription.plan.product
          if @stripe_product_id.present?
            @new_plan = Plan.where(stripe_product_id: @stripe_product_id).first rescue nil
            if @new_plan.present?
              # @message = "Plan successfully updated from: #{@current_plan} to #{@new_plan}"
              puts "$$$ Stripe: Create charge 12"
              if @current_plan.id == @new_plan.id
                puts "$$$ Stripe: Create charge 13"
                redirect_to(plans_path, notice: "Plan was already: #{@new_plan.name}")
              else
                puts "$$$ Stripe: Create charge 14"
                @user.stripe_subscription_id = @subscription.id
                @user.plan = @new_plan
                @user.number_of_seats = params['number_of_seats']
                @user.save
                redirect_to(plans_path, notice: "Plan successfully updated from: #{@current_plan.name} to #{@new_plan.name} (#{params['number_of_seats']} seats)")
              end
            else
              puts "$$$ Stripe: Create charge 15"
              redirect_to(plans_path, error: "Error: No Plan Found")
              # @message = "Error: No Plan Found"
            end
          else
            redirect_to(plans_path, error: "Error: Missing Stripe Product Id")
            # @message = "Error: Missing Stripe Product Id"
          end
        end

      else
        redirect_to(plans_path, error: "Error: No User Found")
        # @message = "Error: No User Found"
      end
    else
      redirect_to(plans_path, error: "Error: Wrong Stripe Data")
      # @message = "Error: Wrong Stripe Data"
    end

    # flash[:error] = @message
    # redirect_to plans_path


    # Stripe.api_key = "STRIPE_TEST_KEY_REDACTED"
    #
    # plan = Stripe::Plan.create(
    #   nickname: 'Lint Monthly Subscription',
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
    # redirect_to plans_path
    redirect_to(plans_path, error: "Error: Stripe Error.")
    # redirect_to new_charge_path
  end


end
