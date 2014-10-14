# ActsAsKeyed
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/jhubert/acts-as-keyed?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

A simple plugin that automatically generates a key for a model on create. It takes care of protecting the key, automatically generating it and making sure it is unique.

The key is based on Tantek's NewBase60 schema to make human readable keys, but you can change the chars used by passing in an option to the acts_as_keyed method.

http://tantek.pbworks.com/w/page/19402946/NewBase60

## Options

* **as_params** [*False*] If true, this will be used as the id of the object when creating URLs and you will be able to Object.find(key)
* **size** - [_10_] The number of characters to make the key
* **chars** - [_NewBase60_] An array of Chars to use when generating the key
* **column** - [*key*] The name of the column to store the key. Accepts a symbol or string.

## Example

    create_table "projects" do |t|
      t.string   "key"
    end

    class Project < ActiveRecord::Base
      acts_as_keyed :as_params => true
    end

    Project.create
    Project.first.key 
    => '8xsk38s92p'

    Project.find('8xsk38s92') == Project.find(1)

Copyright (c) 2011 Jeremy Hubert, released under the MIT license
