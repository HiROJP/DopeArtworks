CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    # アクセスキー
    aws_access_key_id:     'AKIA27APGATJVSYR3MOB',
    # シークレットキー
    aws_secret_access_key: '1WF9k1QnEb9MU3Xugkxqvq/lZg+8Q29ynOs2s4IX',
    # 
    region:                'us-east-1',
  }

  # 公開・非公開の切り替え
  config.fog_public     = true
  # キャッシュの保存期間
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }

  # キャッシュをS3に保存
  # config.cache_storage = :fog

  # 環境ごとにS3のバケットを指定
  case Rails.env
  when 'development'
      config.fog_directory  = 'dopeartworks'
      config.asset_host = 'https://s3.amazonaws.com/dopeartworks'
  when 'production'
      config.fog_directory  = 'dopeartworks'
      config.asset_host = 'https://s3.amazonaws.com/dopeartworks'
  end
end

# 日本語ファイル名の設定
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/