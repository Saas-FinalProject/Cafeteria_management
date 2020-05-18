class ReportsController < ApplicationController
  def index
    if params[:start_date] == "" || params[:end_date] == ""
      flash[:error] = "Give The valid Date Range"
      redirect_to reports_path
    else
      orders = Order.where("status = ? AND delivered_at >= ? AND delivered_at <= ? ", "delivered", params[:start_date], params[:end_date])
      if params[:customer_id] != ""
        orders = orders.where("user_id = ? ", params[:customer_id])
      end
      render "index", locals: { orders: orders ,start_date: params[:start_date], end_date: params[:end_date], customer_id: params[:customer_id]}
    end
  end

  def invoice
    order = Order.find(params[:id])
    render "invoice", locals: { order: order }
  end
end
