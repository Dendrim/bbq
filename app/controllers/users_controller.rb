class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :set_current_user, except: %i[show]

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: I18n.t('controllers.users.updated')
    else
      render :edit
    end
  end

  private
    def set_current_user
      @user = current_user
    end
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
