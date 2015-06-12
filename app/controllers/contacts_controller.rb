class ContactsController < ApplicationController
  def import
    if params[:file]
      begin
        Contact.import(params[:file])
        flash[:success] = "The Contact Sheet has been successfully imported!"
      rescue UnknownFileType
        flash[:error] = "Incorrect File Type, Must be .xlxs"
      rescue ColumnError
        flash[:error] = "The Column Name On the Excel Sheet Is Incorrect"
      ensure
        redirect_to root_path
      end
    else
      flash[:notice] = "No File Imported"

      redirect_to :action => 'index'
    end


    # redirect_to :action => 'index'
  end
end
