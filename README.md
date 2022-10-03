# XLSX-Creator-Web
after passing to file path and json you want to input to the Excel,  
make Excel and return it base64 encoded.

## how to request
### URL
[URL]/api/v1/form

### method
POST

### request header
```
{
   "Content-Type": "application/json",
   "X-XLSX-CREATOR-EMAIL": "YOUR-EMAIL",
   "X-XLSX-CREATOR-PASSWORD": "YOUR-PASSWORD",
}
```

### request body
```
{
  "formId": "1",
    "data": {
    "cell": {
      "field1": {
        "value": "hello"
      },
      "field2": {
        "value": "world"
      }
    },
    "row": {
      "detail": {
        "value": [
          {
            "filedInRow1-1": {
              "value": "value_1-1"
            },
            "filedInRow1-2": {
              "value": "value_1-2"
            },
            "filedInRow1-3": {
              "value": "value_1-3"
            }
          },
          {
            "filedInRow2-1": {
              "value": "value_2-1"
            },
            "filedInRow2-2": {
              "value": "value_2-2"
            },
            "filedInRow2-3": {
              "value": "value_2-3"
            }
          }
        ]
      }
    }
  }
}
```

### response
#### success
```
{
   base64: "base64 encoded data"
}
```

#### error
```
{
   message: "error message"
}
```
 
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

