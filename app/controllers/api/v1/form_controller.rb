module Api
  module V1
    class FormController < APIController
      def new
        return render json: {test: "aswsdf"}
      end
    end
  end
end
