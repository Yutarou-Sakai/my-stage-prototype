class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :has_admin?, only: [:index, :show, :edit, :update]

  def index
    @ransack_users = User.ransack(params[:q])
    @pagy, @users = pagy(@ransack_users.result(distinct: true).order(updated_at: :DESC))
  end

  def show

  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User roles were successfully updated.'
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit({role_ids: []})
  end

  def has_admin?
    unless current_user.has_role?(:admin)
      redirect_to root_path
    end
  end
end
