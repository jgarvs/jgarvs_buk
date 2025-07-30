class CompanyChannel < ApplicationRecord
  belongs_to :company
  belongs_to :channel
end
