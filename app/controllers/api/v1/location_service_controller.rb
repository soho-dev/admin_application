module Api
  module V1
    class LocationServicesController < ApiApplicationController
      def create
        byebug
        @response = ::LocationService.get_address_info({address: params["address"]})
        respond_to do |format|
          if @response.status == 200
            @address = Address.create_address(@response.body)
            if @address.present? && @address.save
              format.json{ render json: @address, status: 200 }
            else
              format.json{ render json: { message: "Address not eligible." }, status: 404 }
            end
          else
            format.json{ render json: { message: "Location service error" }, status: 500 }
          end
        end
      end
    end
  end
end
