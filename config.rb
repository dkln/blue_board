###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

configure :build do
  activate :i18n
  localize
end

set :images_dir, "assets/images"
set :css_dir,    "assets/stylesheets"
set :js_dir,     "assets/javascripts"
