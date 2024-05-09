---
layout: post
title:  "🐙 Setup Github Primer Design with Rails"
date:   2024-05-07 19:18:53 +0000
categories: rails7 github primer design
---

### Seting up rails app with github primer

In your Gemfile, add:
```Gemfile
gem "primer_view_components"
```
alternatively
```
$ bundle add primer_view_components
```

In config/application.rb, add after the application definition:

```ruby
require "view_component"
require "primer/view_components"
```

### CSS
Load CSS as a JS module into the pipeline. Update app/assets/config/manifest.js with:

```css
//= link primer_view_components.css
```

Add it in your application.html.erb in the <head> tag:
```html
<%= stylesheet_link_tag("primer_view_components") %>
```

### JS
Optionally, to add the JavaScript behaviours, in your application.html.erb in the <head> tag add:
```js
<%= javascript_include_tag("primer_view_components") %>
```
Or alternatively, you can install the @primer/view-components npm package and in your JavaScript code add:
```js
import '@primer/view-components'
```
You can also import only the components you need:

```js
import '@primer/view-components/tab_container'
```

Usage
Render Primer ViewComponents in Rails templates:
```erb
<%= render(Primer::Beta::Counter.new(count: 25)) %>
```
Dependencies
In addition to the dependencies declared in the gemspec, Primer ViewComponents assumes the presence of Primer CSS.

-----

https://primer.style/guides/rails
