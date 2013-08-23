class ChargesController < ApplicationController
  def create
    puts 'charge create'
    Stripe.api_key = "sk_test_GZegRpW5nAMf6dNlJBXvFipc"
    token = params[:token]
    amount = params[:amount]
    should_update = true
    begin
      charge = Stripe::Charge.create(
        amount: amount,   # amount in cents
        currency: 'usd',
        card: token,
        description: "Crediting user #{ params[:user_id] } with #{ amount }"
      )
    rescue Stripe::CardError => e
      # Card was declined
      should_update = false
    end

    if should_update
      user = User.find(params[:user_id])
      user.credits = user.credits + amount.to_i
      user.save
    end

    cookies[:current_user] = user.remember_token
    # respond_to do |format|
    #   format.json { head :ok }
    # end
    render json: { credits: user.credits }
  end
end
