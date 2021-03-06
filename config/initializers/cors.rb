Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:8080'

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: %w[Current-Page Page-Items Total-Count Total-Pages],
             credentials: true
  end
end
