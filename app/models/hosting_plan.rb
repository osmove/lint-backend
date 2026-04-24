class HostingPlan < ApplicationRecord
  has_many :repositories

  validates :memory, presence: true
  validates :storage, presence: true
  validates :vcpus, presence: true
  validates :transfer, presence: true
  validates :price_per_month, presence: true

  include ActionView::Helpers::NumberHelper

  def smart_price_per_month
    @smart_price_per_month = if price_per_month.present? && price_per_month.positive?
                               "$#{price_per_month.to_i}/mo"
                             else
                               'Free'
                             end
  end

  def smart_memory
    return if memory.blank?

    number_to_human(memory, units: { unit: 'MB', thousand: 'GB', million: 'TB' })
  end

  def smart_storage
    return if storage.blank?

    number_to_human(storage, units: { unit: 'MB', thousand: 'GB', million: 'TB' })
  end

  def smart_vcpus
    return if vcpus.blank?

    "#{vcpus} vCPUs"
  end

  def smart_transfer
    return if transfer.blank?

    number_to_human(transfer, units: { unit: 'MB', thousand: 'GB', million: 'TB' })
  end

  def price_per_hour
    @price_per_hour = (price_per_month.to_i / 30.0 / 24.0).round(5) if price_per_month.present?
    @price_per_hour
  end

  def description
    @description = ''
    @description << smart_memory.to_s if memory.present?
    @description << " | #{smart_vcpus}" if vcpus.present?
    @description << " | #{smart_storage}" if storage.present?
    @description << " | #{smart_transfer}" if transfer.present?
    @description << " | #{smart_price_per_month}"
    @description
  end

  def to_s
    description
  end
end
