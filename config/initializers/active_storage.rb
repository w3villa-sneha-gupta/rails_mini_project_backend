Rails.application.config.after_initialize do
    ActiveStorage::Current.url_options = { host: 'localhost:3000', protocol: 'http' }
  end