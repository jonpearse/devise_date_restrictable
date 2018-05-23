class User < ActiveRecord::Base

  devise :date_restrictable

end
