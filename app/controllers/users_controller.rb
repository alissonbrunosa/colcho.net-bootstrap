#-- encoding=utf-8

class UsersController < ApplicationController

	before_filter :can_change, only: [:edit, :update]
	before_filter :require_no_authentication, only: [:new, :create] 

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

	
  def create
  	User.transaction do
    	@user = User.new(params[:user])

    	if @user.save
   	 		SignupMailer.confirm_email(@user).deliver
  	    redirect_to @user, notice: "Usuário salvo com sucesso"
	    else
     		render :new
    	end
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to @user, notice: "Usuário atualizado com sucesso"
    else
      render :edit
    end
  end
  
  def can_change
  	unless user_signed_in? && current_user == user
  		redirect_to user_path(params[:id])
	  end
  end
  
  def user
  	@user ||= User.find(params[:id])
  end
  
 

end
