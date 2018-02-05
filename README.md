Ruby ISBNdb
===========
Ruby ISBNdb is a simple, Ruby library that connects to [ISBNdb.com's Web Service](http://isbndb.com) and API. Ruby ISBNdb is written to mimic the ease of ActiveRecord and other ORM programs, without all the added hassles. It's still in beta phases, but it is almost fully functional for the basic search features of ISBNdb.

Version 1.x
-----------
*ISBNdb 1.x.x has been deprecated!*. You should upgrade to the new version as soon as possible. The old documentation is still available in the [git history](https://github.com/sethvargo/isbndb/tree/75cfe76d096f92b2dfaf1c1b42d7c84ff86fcbc0). There are *significant* changes in this new version, so please test appropriately.

Installation
------------
To get started, install the gem:

    gem install isbndb

Alternatively, you can add it to your Gemfile:

```ruby
gem 'isbndb', '~> 4.0.0'
```

Basic Setup
-----------
To get started, you'll need to add new ENV in your project root. It should look like this:

```env
  ISBNDB_API_KEY: YOUR-KEY
```

Now you're ready to get started:

```ruby
isbndb = ISBNdb::Client.new
@query = isbndb.book('9788812345678')
```

ActiveRecord-like Usage
-----------------------
Another reason why you'll love Ruby ISBNdb is it's similarity to ActiveRecord. In fact, it's *based* on ActiveRecord, so it should look similar. It's best to lead by example, so here are a few ways to search for books, authors, etc:

```ruby
isbndb = ISBNdb::Client.new
@books = isbndb.books('Book Title')
@author = isbndb.author('Author Name')
@authors = isbndb.authors('Partial Name')
@publisher = isbndb.publisher('Publisher Name')
@publishers = isbndb.publishers('Partial Name')
```

If you are unfamiliar with some of these options, have a look at the [ISBNdb API](http://isbndb.com/apidocs/)

Processing Results
------------------
A `ResultSet` is nothing more than an enhanced array of `Result` objects. The easiest way to process results from Ruby ISBNdb is most easily done using the `.each` method.

```ruby
results = ISBNdb::Query.find_books_by_title("Agile Development")
results.each do |result|
  puts "title: #{result.title}"
  puts "isbn10: #{result.isbn}"
  puts "authors: #{result.authors_text}"
end
```

Next features
----------
- Add stats response
- Add paginate for response

Testing
-------
[![Build Status](http://travis-ci.org/sethvargo/isbndb.png)](http://travis-ci.org/sethvargo/isbndb)

Change Log
----------
2018-2-2 - Released v4.0
2012-6-17 - Released v2.0
2011-3-11 - Officially changed from ruby_isbndb to isbndb with special thanks to [Terje Tjervaag](https://github.com/terje) for giving up the gem name :)

Acknowledgments
----------------
Special thanks to Terje Tjervaag (https://github.com/terje) for giving up the gem name 'isbndb'!

Special thanks to Lazlo (https://github.com/lazlo) for forwarding his project here!
