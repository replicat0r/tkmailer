class ContactMailer < ApplicationMailer

	def contact_realtor(email,email_body,fname)
		@realtor_email = email
		@fname = fname
		@body = email_body

    options = {
      :subject => "Appointment With TurnKii Confirmed",
      :email => @realtor_email = email,
      :global_merge_vars => [
        {
          name: "fname",
          content: "#{@fname}"
        },
        {
          name: 'body',
          content: "#{@body}"
        },


      ],
      :template => "realtor_template"
    }
    mandrill_send options

  end

	def mandrill_send(opts={})
    message = {
      :subject=> "#{opts[:subject]}",
      :from_name=> "Michael G",
      :from_email=>"michaelg6xt@gmail.com",
      :to=>
      [{"name"=>"#{opts[:email]}",
        "email"=>"#{opts[:email]}",
        "type"=>"to"}],
      :global_merge_vars => opts[:global_merge_vars]
    }
    sending = MANDRILL.messages.send_template opts[:template], [], message
  rescue Mandrill::Error => e
    Rails.logger.debug("#{e.class}: #{e.message}")
    raise
  end

end
