class TokenAuthenticationStrategy < ::Warden::Strategies::Base
  def valid?
    env['HTTP_AUTHORIZATION'].present?
  end

  def store?
    false
  end

  def authenticate!
    user = User.for_auth(token)
    if user
      success!(user)
    else
      fail!(I18n.t('warden.messages.failure'))
    end
  end

  def token
    env['HTTP_AUTHORIZATION'].sub('Token token=', '')
  end
end
