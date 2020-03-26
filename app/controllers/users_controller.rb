# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: %i[edit update destroy]

  def index
    logger.info "UsersController::index permit_params #{params}"
    @q_user = User.ransack(params[:q])
    @users = @q_user.result.page(params[:page]).order('created_at desc')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(permit_params)
    unless @user.errors.blank?
      flash[:danger] = @user.errors.full_messages.to_sentence
      render(action: :new) && return
    end
    redirect_to action: :index
  end

  def edit; end

  def update
    @user.update_attributes(permit_params)
    redirect_to action: :index
  end

  def destroy
    @user.destroy!
    redirect_to action: :index
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def permit_params
    params[:user].permit!
  end
end
