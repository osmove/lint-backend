class HostingPlan < ApplicationRecord

  has_many :repositories

  validates :memory, presence: true
  validates :storage, presence: true
  validates :vcpus, presence: true
  validates :transfer, presence: true
  validates :price_per_month, presence: true

  include ActionView::Helpers::NumberHelper

  def smart_price_per_month
    if self.price_per_month.present? && self.price_per_month > 0
      @smart_price_per_month = "$#{self.price_per_month.to_i}/mo"
    else
      @smart_price_per_month = "Free"
    end
  end

  def smart_memory
    if self.memory.present?
      number_to_human(self.memory, units: {unit: "MB", thousand: "GB", million: "TB"})
    end
  end

  def smart_storage
    if self.storage.present?
      number_to_human(self.storage, units: {unit: "MB", thousand: "GB", million: "TB"})
    end
  end

  def smart_vcpus
    if self.vcpus.present?
      "#{vcpus} vCPUs"
    end
  end

  def smart_transfer
    if self.transfer.present?
      number_to_human(self.transfer, units: {unit: "MB", thousand: "GB", million: "TB"})
    end
  end

  def price_per_hour
    if self.price_per_month.present?
      @price_per_hour = (self.price_per_month.to_i / 30.0 / 24.0).round(5)
    end
    @price_per_hour
  end

  def description
    @description = ""
    @description << "#{self.smart_memory}" if self.memory.present?
    @description << " | #{self.smart_vcpus}" if self.vcpus.present?
    @description << " | #{self.smart_storage}" if self.storage.present?
    @description << " | #{self.smart_transfer}" if self.transfer.present?
    @description << " | #{self.smart_price_per_month}"
    @description
  end


  def to_s
    self.description
  end

end
