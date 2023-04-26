class SubscriptionsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_subscription, only: %i[ destroy ]

  # GET /subscriptions or /subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # PATCH/PUT /subscriptions/1 or /subscriptions/1.json
  def update
  end
  # POST /subscriptions or /subscriptions.json
def create
  @new_subscription = @event.subscriptions.build(subscription_params)
  @new_subscription.user = current_user

  if @event.user == current_user
    flash.now[:notice] = I18n.t('controllers.subscriptions.cant_subscribe_to_your_own_event')
    render 'events/show', status: :unprocessable_entity
  elsif User.where(email: @new_subscription&.user&.email || @new_subscription.user_email).exists? && current_user.blank?
    flash.now[:notice] = I18n.t('controllers.subscriptions.cant_sub_registered')
    render 'events/show', status: :unprocessable_entity
  elsif @new_subscription.save
    redirect_to @event, notice: I18n.t('controllers.subscriptions.created')
  else
    render 'events/show', status: :unprocessable_entity
  end
end

def destroy
  message = {notice: I18n.t('controllers.subscriptions.destroyed')}
  if current_user_can_edit?(@subscription)
    @subscription.destroy
  else
    message = {alert: I18n.t('controllers.subscriptions.error')}
  end

  redirect_to @event, message
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = @event.subscriptions.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.fetch(:subscription, {}).permit(:user_email, :user_name)
    end
end
