class Collaboration < ApplicationRecord
	belongs_to :user, foreign_key: "collaborator_id"
	belongs_to :project

end
