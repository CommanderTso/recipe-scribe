if Rails.env.test?

  Fog.mock!
  FogStorage = Fog::Storage.new(
    provider: "Google",
    google_storage_access_key_id: "mock",
    google_storage_secret_access_key: "mock"
  )
  FogStorage.directories.create key: "testbucket", acl: "public-read"
  StorageBucket = FogStorage.directories.get "testbucket"

else

  config = Rails.application.config.x.settings["cloud_storage"]

  FogStorage = Fog::Storage.new(
    provider: "Google",
    google_storage_access_key_id:     config["access_key_id"],
    google_storage_secret_access_key: config["secret_access_key"]
  )

  StorageBucket = FogStorage.directories.new key: config["bucket"]

end
