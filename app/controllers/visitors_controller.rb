class VisitorsController < ApplicationController
  def index
    @contacts = Contact.all.paginate(:per_page => 100,:page => params[:page])
    @column_names=Contact.column_names


    @column_names -= %w[updated_at created_at id]
  end


end
