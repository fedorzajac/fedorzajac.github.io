---
layout: post
title:  "Kubernetes argocd helm automation"
date:   2024-09-22 13:01:33 +0200
categories: Kubernetes argocd helm automation
---

### Deployment Automation

Ruby script for filling out template file from existing running configuration and creating values file for Helm

```ruby
require 'yaml'

@template = YAML.safe_load(File.read(ARGV[0]))
@running = YAML.safe_load(File.read(ARGV[1]))

@values = []

def go_deep(h, path = [])
  if h.is_a?(Hash)
    h.each do |key, value|
      new_path = path + [key]  # Create a new array for each recursion
      go_deep(value, new_path)
    end
  elsif h.is_a?(Array)
    h.each_with_index do |item, index|
      new_path = path + [index]  # Include index in path for arrays
      go_deep(item, new_path)
    end
  else
    # Print the current path and value
    p path
    puts h
    running_value = @running.dig(*path)
    # Compare the template value with the running value (uncomment if needed)
    if h[0] == "$"
      @values << "#{h}: #{running_value} # #{path.join("-")}"
    end
  end
end

go_deep(@template)

@values.each do |val|
  puts val
end
```
