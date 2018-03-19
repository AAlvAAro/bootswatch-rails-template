# Bootswatch 3 Rails Template

## Setup

- Clone the repository

- Run the rails new command with the -m option passing the path of the rails_app_template.rb file and using postgres as the database like so:
  `rails new myapp -m local_path_to/rails_app_template.rb -d postgresql`

- You will be asked to write one of Bootswatch's template names in order to add that styling to the app. You can find the options
  here https://bootswatch.com/3/

- Cd into the project and run the setup script:
  `./bin/setup`

- You're done! Run the app
  'rails s'
