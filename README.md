# Test Devise Users - basic set-up with Rails 7 + Users Resources

Reference: https://www.digitalocean.com/community/tutorials/how-to-set-up-user-authentication-with-devise-in-a-rails-7-application

## Initial setup:

1. Create a new app:
```
rails new test-devise-basic --css=bootstrap --javascript=esbuild --database=postgresql
```

2. bundle install
```
bundle install
```

3. type the bin/setup command to install the dependencies and create the database:
```
bin/setup
```

4. We can now run the rails server, and the scripts that precompile the CSS and the JavaScript code with the bin/dev command:
```
bin/dev
```

5. We can now go to http://localhost:3000, and we should see the Rails boot screen.

6. If you cloned this, Precompile javascript/css: ```rails assets:precompile```

## Create a landing page:

7. Create a new controller named "home" by running the following command in your terminal:
```
rails generate controller Home index
```

8. Open the config/routes.rb file and add the following line:
```
root 'home#index'
or
get '/home', to: 'home#index'
```
## Installing and Configuring Devise

9. add Devise gem:
```
gem "devise"
```

10. bundle install
```
bundle install
```

11. All the Devise gem to generate your assets:
```
bin/rails g devise:install
```
That got you this:<br>
* create  config/initializers/devise.rb
* create  config/locales/devise.en.yml

12. Open config/initializers/devise.rb for editing - This line adds turbo_stream as a navigational format. You need to add this for Devise 4.8.1 to work with Rails 7; otherwise, you’d get an undefined method user_url error.
```
Devise.setup do |config|
  # ...

  config.navigational_formats = ['*/*', :html, :turbo_stream]

  # ...
end
```

13. make sure we have the flash message stuff in app/views/layouts/application.html.erb:
```
<body>
  <p class="notice"><%= notice %></p> 
  <p class="alert"><%= alert %></p> 
  <%= yield %>
</body>
```
* You can copy Devise views (for customization) to your app by running: ```rails g devise:views```

## Creating the User Model with Devise

14. To create your Devise user, run the following generator command:
```
bin/rails g devise user
```
That gets you this:
```
invoke  active_record
create    db/migrate/20230503153643_devise_create_users.rb
create    app/models/user.rb
invoke    test_unit
create      test/models/user_test.rb
create      test/fixtures/users.yml
insert    app/models/user.rb
route  devise_for :users
```
** Open up the migration file make sure it has what you need: db/migrate - Open the app/models/user.rb model file to review the default code - it added a route too **

15. Run the migration we just created:
```
bin/rails db:migrate
```

16. Restart your server - Ctrl + C then ```bin/dev```

17. Go to ```http://localhost:3000/users/sign_up``` in your browser, where you will find a sign-up form to create an account by entering an email and password.

18. You can copy Devise views (for customization) to your app by running:
```
bin/rails g devise:views
```
** I am adding basic ```<div class="container"></div>``` around the views I am interacting with **

19. Sign up and test
```
Welcome! You have signed up successfully.
```

## Linking Authentication to the Landing Page

20. Open the app/views/home/index.html.erb file for editing and add the highlighted lines:
```
<% if user_signed_in? %> 
 <div> Welcome <%= current_user.email %> </div> 
  <%= button_to "Sign out", destroy_user_session_path, method: :delete %> 
<% else %>
  <%= button_to "Sign in", new_user_session_path %> 
<% end %>
```

21. restyling the flash messages:
```
<% flash.each do |type, msg| %>
  <div class="alert alert-<%= type %> alert-primary alert-dismissible fade show" role="alert">
    <%= msg %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
<% end %>
```

This is a fully functional, basic set-up.







