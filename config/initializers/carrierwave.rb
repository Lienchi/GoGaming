if Rails.env.production?
  CarrierWave.configure do |config| 
      config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     ENV['S3_ACCESS_KEY'],
        aws_secret_access_key: ENV['S3_SECRET_KEY'],
        region:                'us-west-2'
      }
      config.fog_directory  = ENV['S3_BUCKET']
  end

  # --- GCP
  #if Rails.env.production?
  #  CarrierWave.configure do |config|
  #    config.storage                             = :gcloud
  #    config.gcloud_bucket                       = 'gogaming'
  #    config.gcloud_bucket_is_public             = true
  #    config.gcloud_authenticated_url_expiration = 600
  #    
  #    config.gcloud_attributes = {
  #      expires: 600
  #    }
  #    
  #    config.gcloud_credentials = {
  #      gcloud_project: 'GoGaming',
  #      gcloud_keyfile: 'gcp-keyfile.json'
  #    }
  #  end
  #end
end