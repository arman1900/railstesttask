class User < ApplicationRecord
    has_many :posts
    has_secure_password
    attr_accessor :remember_token
    validates_presence_of :name,:login,:email,:address,:country,:zip,:state,:role,:city,:birthday
    validates_uniqueness_of :login
    validates_email_format_of :email, message: 'The email format is not correct!'
    enum role: {client: 0, worker: 1, admin: 2}

    before_save { self.email = email.downcase }
    before_save { self.login = login.downcase }

    def location
        [address, city, country].compact.join(', ')
    end
    def send_password_reset
        generate_token(:password_reset_token)
        self.password_reset_sent_at = Time.zone.now
        save!
        UserMailer.forgot_password(self).deliver# This sends an e-mail with a link for the user to reset the password
      end
      def generate_token(column)
        begin
          self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
    end
    def update_with_password(password_params)
        current_password = password_params.delete(:current_password)
        if self.authenticate(current_password)
          self.update(password_params)
          true
        else
          self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
          false
        end
    end
    class << self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end

        def new_token
            SecureRandom.urlsafe_base64
        end
    end
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    def forget
        update_attribute(:remember_digest, nil)
    end
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
end
