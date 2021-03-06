class Recipe < ActiveRecord::Base
  validates :title, presence: true
  validates :recipe_ingredients, presence: true
  validates :user, presence: true

  belongs_to :user
  #TODO - The order of the next two statements matters A LOT
  # If they are switched, ingredients gets deleted before
  # increments can de-increment itself from the shopping list_items
  # Need to find a way around this that is more future-proof
  has_many :recipe_increments, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  accepts_nested_attributes_for :recipe_ingredients,
    reject_if: :reject_recipe_ingredients,
    allow_destroy: true
  after_initialize :init
  attr_accessor :recipe_image

  private

  def init
    self.image_url = "https://storage.googleapis.com/recipe-scribe/recipe_images/food-icon.svg" if self.image_url.blank?
  end

  def reject_recipe_ingredients(attributed)
    attributed['quantity'].blank? || attributed['measurement_unit_id'].blank? || attributed['ingredient_id'].blank?
  end

  after_create :upload_image, if: :recipe_image

  def upload_image
    image = StorageBucket.files.new(
      # TODO - Google's tutorial project does no sanitization, and spaces
      # cause the filename to get mangled & the record to fail to save
      # This fixes it, need to check if there's still a security issue
      key: "recipe_images/#{id}/#{recipe_image.original_filename.tr(' ', '_')}",
      body: recipe_image.read,
      public: true
    )

    image.save

    update_columns image_url: image.public_url
  end

  before_destroy :delete_image, if: :image_url

  def delete_image
    bucket_name = StorageBucket.key
    image_uri = URI.parse image_url

    if image_uri.host == "#{bucket_name}.storage.googleapis.com"
      image_key = image_uri.path.sub("/", "") # has to come off to match bucket file name
      image     = StorageBucket.files.new key: image_key

      image.destroy
    end
  end

  before_update :update_image, if: :recipe_image

  def update_image
    delete_image if image_url?
    upload_image
  end
end
