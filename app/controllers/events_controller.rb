class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_event, only: %i[show edit update destroy]

  after_action :verify_authorized
  after_action :verify_policy_scoped, only: %i[index]

  def index
    @events = policy_scope(Event)
    authorize @events
  end

  def show
    authorize @event
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  def new
    @event = current_user.events.build
    authorize @event
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)
    authorize @event

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: I18n.t('controllers.events.created') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @event

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: I18n.t('controllers.events.updated') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @event
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: I18n.t('controllers.events.destroyed') }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description)
  end
end
