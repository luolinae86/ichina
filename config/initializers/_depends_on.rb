# frozen_string_literal: true

class Module
  # 允许你将一个大型的类型拆分成多个独立的文件来管理
  #
  #   # app/models/user.rb
  #   class User
  #     depends_on :authorization, :two_factor
  #   end
  #
  #   # app/models/user/authorization_dependency.rb
  #   class User
  #     has_many :authorizations
  #   end
  #
  #   # app/models/user/two_factor_dependency.rb
  #   class User
  #     has_many :two_factors
  #
  #     def two_factors_activited?
  #     end
  #   end
  def depends_on(*files)
    files.each do |f|
      puts "#{name.underscore}/#{f}_dependency"
      require_dependency "#{name.underscore}/#{f}_dependency"
    end
  end
end
