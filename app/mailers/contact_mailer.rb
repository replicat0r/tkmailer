class ContactMailer < ApplicationMailer




  def contact_realtor
    subscribers = Contact.pluck(:id)

    if subscribers.count > 0
      recipients = convert_users_to_mandrill_recipients(subscribers)
      merge_vars = convert_users_to_mandrill_merge_fields(subscribers)
      body = ActionController::Base.new.
        render_to_string("contact_mailer/contact.html.erb",
                         :layout => false)

        m = Mandrill::API.new ENV['MAILER_MANDRILL_API_KEY']
      message = {
        :from_name=> "Michael G",
        :from_email=>"michaelg6xt@gmail.com",
        :to=> recipients,
        :subject=> "Looking for real estate advice",
        :html=> body,
        :merge_vars => merge_vars,
        :preserve_recipients => false,
        :global_merge_vars => [
          {name: "category", content: "category.name"},
          {name: "video_title", content: "video.title"}
        ]
      }
      begin

      m.messages.send message
      rescue Mandrill::Error => e
        Rails.logger.debug("#{e.class}: #{e.message}")
        raise
      end
    end
  end


  def convert_users_to_mandrill_recipients(user_ids)
    user_ids.map do |user_id|
      user = Contact.find(user_id)
      {:email => user.email}
    end
  end

  def convert_users_to_mandrill_merge_fields(user_ids)
    user_ids.map do |user_id|
      user = Contact.find(user_id)
      {:rcpt => user.email, :vars => [{:name => "first_name", :content => user.fname}]}
    end
  end


  # def contact_realtor(email_list,email_body,fname)
  #   @fname = fname
  #   @body = email_body

  #    options = {
  #      :subject => "Appointment With TurnKii Confirmed",
  #      :email => email_list,
  #      :global_merge_vars => [
  #        {
  #          name: "fname",
  #          content: "#{@fname}"
  #        },
  #        {
  #          name: 'body',
  #          content: "#{@body}"
  #        },


  #      ],
  #      :template => "realtor_template"
  #    }
  #    mandrill_send options

  #  end

  # def mandrill_send(opts={})
  #    message = {
  #      :subject=> "#{opts[:subject]}",
  #      :from_name=> "Michael G",
  #      :from_email=>"michaelg6xt@gmail.com",
  #      :to=> "#{opts[:subject]}",
  #      :global_merge_vars => opts[:global_merge_vars]
  #    }
  #    sending = MANDRILL.messages.send_template opts[:template], [], message


end
