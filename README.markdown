ActiveRecord standalone example with migrations included

USAGE
=====
Install bundler and run it:
    gem install bundler
    bundle

Put your models on "models/*.rb". To create a new migration:
    rake db:new_migration name=create_roles

After filling the migration:
    rake db:migrate

If you want to experiment in IRB:
    irb -I . -r bootstrap

In IRB:
    User.all # []
    User.create name: "My User Name"
    User.count # 1
