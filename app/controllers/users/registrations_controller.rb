# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
   
  # before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
   build_resource
    yield resource if block_given?
    respond_with resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

  end

  # GET /resource/edit
  def edit
    # build_resource(current_user)
    # yield resource if block_given?
     
     self.resource = User.find(current_user.id)
    # respond_with self.resource
  end

  # PUT /resource
  def update
    @user = User.find(current_user.id)
    if @user.update(configure_account_update_params)
        flash[:notice] = 'Profile users was updated , login please !'
          sign_in(current_user, :bypass => true)
      else
        render :action => :show
      end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    # devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
     params.require(:user).permit(:firstname,:lastname ,:email,:password,:phone,:address)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  def sign_up_params
        params.require(:user).permit(:firstname,:lastname ,:email,:password,:phone,:address)
  end
  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end