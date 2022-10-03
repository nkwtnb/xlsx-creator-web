Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # どのオリジンからのリクエストも許可する
    origins '*'
    resource '/api/v1/form',
             headers: :any,
             methods: [:post]
  end
end