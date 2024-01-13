---
layout: post
title:  "🚅 Rails7 Setup with Mongoid and RSpec"
date:   2024-01-12 09:11:03 +0100
categories: rails7 mongoid rspec
---

# How to create new rails7 app with mongoid and rspec

Create new application with rails 7

```bash
rails new app --skip-active-record --skip-test --skip-system-test
cd app
bundle add mongoid
bundle install
rails g mongoid:config # creates yml
```

adding rspec

```bash
bundle add rspec-rails --group "development, test"
bundle install
rails g rspec:install
```

note: you may also need to add `bundle exec` in front of rails command

reference: [mongoid], [rails7 guides], [bundler], [rspec]

[mongoid]: https://www.mongodb.com/docs/mongoid/current/tutorials/getting-started-rails7/

[rails7 guides]: https://guides.rubyonrails.org/
[bundler]: https://manpages.ubuntu.com/manpages/focal/en/man1/bundle-add.1.html
[rspec]: https://rspec.info/features/6-0/rspec-rails/