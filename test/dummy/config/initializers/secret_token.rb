if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR == 0
  Dummy::Application.config.secret_key_base = '0e085a62fbfd58069441e0eb7dd8c3d0a7035017443181a5fba2c04041a03f8d0d427216ac56a51da79125898d125bb9fb8badb48404919fe3188eb309231570'
end
