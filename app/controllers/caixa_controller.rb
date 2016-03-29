class CaixaController < ApplicationController

  def index
    if cliente_signed_in?
      redirect_to cliente_path current_cliente
      return
    end
  end
  def new
    return root_path
  end

  def not_found
    respond_to do |format|
      format.html { render status: 404 }
    end
  rescue ActionController::UnknownFormat
    render status: 404, text: "nope"
  end
end
