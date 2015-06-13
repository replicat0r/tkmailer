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
      flash[:error] = "File Upload Slot Empty"

      redirect_to root_path
    end


    # redirect_to :action => 'index'
  end


  def send_email
    #user_list_id = Contact.pluck(:id)
    #email_list = convert_id_to_email(user_list_id)
    #puts email_list

    ContactMailer.contact_realtor.deliver_now
    flash[:notice] = "Email Send to all contacts on the list"

    redirect_to root_path



  end

  def purge_db
    contacts = Contact.all
    contacts.delete_all

    flash[:success] = "All Data Purged!"
    redirect_to root_path


  end
end
