class Trade < ApplicationRecord
	belongs_to :book
	belongs_to :user
	enum trade_status: { waiting: 0, approve: 1, deny: -1 }
end
