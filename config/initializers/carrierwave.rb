if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage                             = :gcloud
    config.gcloud_bucket                       = 'gogaming'
    config.gcloud_bucket_is_public             = true
    config.gcloud_authenticated_url_expiration = 600
    
    config.gcloud_attributes = {
      expires: 600
    }
    
    config.gcloud_credentials = {
      gcloud_project: 'GoGaming',
      gcloud_keyfile: 'gcp-keyfile.json'
    }
  end
end