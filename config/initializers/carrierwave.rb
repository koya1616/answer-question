unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.cache_storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 's3-rails-koya'
    config.asset_host = 'https://s3.amazonaws.com/s3-rails-koya'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region: 'ap-northeast-1'
    }

  end
end

