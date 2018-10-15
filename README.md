# Bootswatch 3 Rails Template

## Install

Just clone this repository:

```
$ git clone https://github.com/AAlvAAro/bootswatch-rails-template.git
```

## Usage

1. To create a brand new Rails app using a template you need to provide the Rails generator with the location of the generator you want to use by passing the `-m` option:

   ```
   $ rails new my_example_app -m local_path_to/rails_app_template.rb -d postgresql
   ```

2. You will be asked to write one of Bootswatch's template names in order to add that styling to your app. You can find the different ones here https://bootswatch.com/3/

   ```
   Default
   Cerulean
   Cosmo
   Cyborg
   Darkly
   Flatly
   Journal
   ...
   ```

3. Enter into your app's folder and run the setup script:

   ```
   ./bin/setup
   ```

4. You're all done! See it live by running:

   ```
   rails s
   ```

## Contributing

1. Fork it
2. Clone to your local (`git clone git@github.com:AAlvAAro/bootswatch-rails-template.git`)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
