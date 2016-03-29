class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def after_sign_in_path_for(cliente)
    if cliente_signed_in?
      return cliente_path(cliente)
    end
  end
end
