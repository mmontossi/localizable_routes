module I18nSupport

  def iterate_locales
    I18n.available_locales.each do |locale|
      @locale = locale
      yield locale
    end
    @locale = nil
  end

  private

  def t(key)
    I18n.t key, locale: @locale
  end

end
