class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, raise: false
  before_action :configure_permitted_parameters,if: :devise_controller?
  respond_to :html, :json
  $user=[]
  $page=1
  $DNTPage = 1
  $DTPage = 1
    def configure_permitted_parameters
      added_attrs = [:nom, :prenom, :email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit(:SearchDemandeNonT) {|u| u.permit(:nom, :prenom, :email, :password, :password_confirmation) }
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
    

    def index
      $page=params[:page]
      $DNTPage = params[:DNTPage]
      $DTPage = params[:DTPage]
      render 'application/index'
    end

    def GetLoggedUserInfo
      $user= current_user
      render json: {status: 'SUCCESS',message: 'GetLoggedUserInfo',data: $user},status: :ok
    end

end
