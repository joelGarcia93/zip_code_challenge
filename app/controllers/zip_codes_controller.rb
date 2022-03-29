class ZipCodesController < ApplicationController
	before_action :set_zip_code, only: [:show]

	def show
		if @zip_code.nil?
			render json: { message: 'Zip code does not exists.' }, status: :not_found
		else
			data = ZipCodeSerializer.new(@zip_code).serialized_json
			render json: data
		end
	end

	private
	def set_zip_code
		@zip_code = ZipCode.find_by(id: params[:id])
	end
end