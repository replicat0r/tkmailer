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

  def send_email
    #user_list_id = Contact.pluck(:id)
    #email_list = convert_id_to_email(user_list_id)
    #puts email_list

    ContactMailer.contact_realtor.deliver_now
    #flash[:notice] = "Message Send"

    redirect_to root_path



  end
  private
  def convert_id_to_email(user_ids)
    user_ids.map do |user_id|
      user = Contact.find(user_id)
      {:email => user.email}
    end
  end
end
