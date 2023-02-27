class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  # new,createの @userは モーダル画面上で usersControllerと共有しているので注意
  def new
    @user = User.new
  end

  def create
    @user = login(params[:user][:email], params[:user][:password])
    if @user
      flash.now[:success] = t('.success')
    else
      flash.now[:danger] = t('.fail')
      # @user に入力値を入れて返す。　パスワードは怖いので入れない
      @user = User.new(email: params[:user][:email])
      # user_sessions/new.js.erb を呼ぶ
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: t('.success')
  end
end
