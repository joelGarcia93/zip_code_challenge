class OrdersController < ApplicationController
	def search
		orders = Order.joins(:merchant).includes(:merchant)
		.where("created_at >= ? AND created_at <= ?", params[:start_date], params[:end_date])
		.where(order_params)
		.where.not(completed_at: nil)
		data = OrderSerializer.new(orders).serialized_json
		render json: data
	end

	private
	def order_params
		params.permit(:merchant_id).reject { |k, v| v.blank? }
	end
end