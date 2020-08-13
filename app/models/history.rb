class History < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :song, dependant: destroy
end
