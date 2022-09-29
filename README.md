# Authentication using JWT in RoR

1. `bundle install` (--path vendor/bundle)
2. add following gems to Gemfile
   - "bcrypt"
   - "jwt"
3. make model
   1. `bundle exec rails g model user name email password_digest`
   2. `bundle exec rails db:migrate`
4. add `has_secure_password` to User model
5. make secret key
   1. `mkdir PATH_TO_PROJECT/auth && $_`
   2. `openssl genrsa 2024 > service.key`
   3. add service.key to .gitignore
6. add authentication module `auth.rb` in `infrastructures` directory

