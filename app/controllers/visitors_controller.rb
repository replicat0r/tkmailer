class VisitorsController < ApplicationController
  def index
    @markdowns = StoreMarkdown.all.paginate(:per_page => 50,:page => params[:page])
    @column_names=StoreMarkdown.column_names

    # @column_names.delete('updated_at')
    # @column_names.delete('id')
    # @column_names.delete('created_at')

    @column_names -= %w[updated_at created_at id]
  end

  def send_mail

  end
end
