## postmen-ruby

[![Build Status](https://travis-ci.org/postmen/postmen-sdk-ruby.svg?branch=master)](https://travis-ci.org/postmen/postmen-sdk-ruby)
[![Code Climate](https://codeclimate.com/github/postmen/postmen-sdk-ruby/badges/gpa.svg)](https://codeclimate.com/github/postmen/postmen-sdk-ruby)
[![Gem Version](https://badge.fury.io/rb/postmen.svg)](https://badge.fury.io/rb/postmen)
[![Dependency Status](https://gemnasium.com/badges/github.com/postmen/postmen-sdk-ruby.svg)](https://gemnasium.com/github.com/postmen/postmen-sdk-ruby)
[![Coverage Status](https://coveralls.io/repos/github/postmen/postmen-sdk-ruby/badge.svg?branch=master)](https://coveralls.io/github/postmen/postmen-sdk-ruby?branch=master)


Ruby Gem for Postmen API.

This extension helps developers to integrate with Postmen easily.

## Early development stage

This gem is on early stage of development - There are a lot of features that are not covered yet, you may also expect heavy changes in the public API, before we hit version `1.0.0` (see the Milestones section)



## Installation

1. Add the following line to your application's Gemfile

    ```
    gem "postmen", "~> 0.1.0"
    ```

2. Run bundler

    ```
    bundle install
    ```

## Configuration

```ruby

Postmen.configure do |config|
  config.region = 'sandbox' # set 'sandbox' or 'production. Required
  config.api_key = 'YOUR API KEY' # Required
  config.endpoint = 'http://my-custom-endpoint.example.com' # Optionally set custom endpoint url.
end

```

## Usage

```ruby
require 'postmen'

# Configure postmen first, see Configuration section

### Fetch all labels:

Postmen::Label.all # Returns an instance of Postmen::LabelCollection

# optionally you can pass additional params to the query:

Postmen::Label.all(shipper_account_id: '1111')
Postmen::Label.all(status: 'created')
# For more options, please see the documentation: https://docs.postmen.com/api.html#labels-list-all-labels

### Fetch single label

Postmen::Label.find('1111') # Returns an instance of Postmen::Label
```

### Label

An instance of `Postmen::Label` responds to following methods:

`id`,
`status`,
`tracking_numbers`
`files`,
`rate`

### LabelCollection

`Postmen::LabelCollection` acts as an Array of `Label` instances. You can do things like:

```ruby
collection = Postmen::Label.all 

collection.first # Returns an instance of Label
collection.size # Returns number of elements returned
collection.each{|label| puts label.inspect } # Iterates over labels
collection.select{|label|  } # Selects labels by given criteria
```
and so on.

## The License (MIT)

Released under the MIT license. See the LICENSE file for the complete wording.


## Contributor
