require 'spec_helper'

describe ISBNdb::Client do
  context 'init setting' do
    it 'apy_key not exists' do
      expect { ISBNdb::Client.new }.to raise_error('APY KEY must be specified')
    end
  end

  context 'with an apy_key error' do
    let(:client) { ISBNdb::Client.new }
    before do
      stub_request(:get, "https://api.isbndb.com/books/Ruby").to_return(:body => File.new('spec/responses/forbidden.json'), :headers => {'Content-Type'=>'application/json'})
    end

    it 'should raise an exception' do
      allow(ENV).to receive(:[]).with("ISBNDB_API_KEY").and_return("123456789012345")

      expect { client.books('Ruby') }.to raise_error(ISBNdb::Errors::ForbiddenAccessKeyError)
    end
  end

  context 'method_missing' do
    let(:client) { ISBNdb::Client.new }
    context 'for a valid method it can handle' do
      it 'should work for books' do
        allow(ENV).to receive(:[]).with("ISBNDB_API_KEY").and_return("123456789012345")
        stub_request(:get, "https://api.isbndb.com/books/Il%20Codice%20Da%20Vinci").to_return(:body => File.new('spec/responses/books.json'), :headers => {'Content-Type'=>'application/json'})

        expect { client.books('Il Codice Da Vinci') }.not_to raise_error

        @books = client.books('Il Codice Da Vinci')
        @books.size.should == 39

        @book = @books.first
        expect(@book.isbn).to eq('1537603086')
        @book.isbn13.should == '9781537603087'
        @book.title.should == 'Il Velo di Maya (Italian Edition)'
        @book.title_long.should == "Il Velo di Maya (Italian Edition)"
        @book.authors.should be_a(Array)
        @book.publisher.name.should == "CreateSpace Independent Publishing Platform"
      end

      it 'should work for book' do
        allow(ENV).to receive(:[]).with("ISBNDB_API_KEY").and_return("123456789012345")
        stub_request(:get, "https://api.isbndb.com/book/9788804523413").to_return(:body => File.new('spec/responses/book.json'), :headers => {'Content-Type'=>'application/json'})

        expect { client.book('9788804523413') }.not_to raise_error

        @book = client.book('9788804523413')

        @book.isbn.should == "8804523413"
        @book.isbn13.should == '9788804523413'
        @book.title.should == 'Il Codice Da Vinci'
        @book.title_long.should == 'il-codice-da-vinci'
        @book.authors.should be_a(Array)
        @book.publisher.name.should == 'Mondadori'
      end

      it 'should work for authors' do
        allow(ENV).to receive(:[]).with("ISBNDB_API_KEY").and_return("123456789012345")
        stub_request(:get, "https://api.isbndb.com/authors/Brown").to_return(:body => File.new('spec/responses/authors.json'), :headers => {'Content-Type'=>'application/json'})

        expect { client.authors('Brown') }.not_to raise_error

        @authors = client.authors('Brown')
        @authors.size.should == 10036

        @author = @authors.first
        @author.name.should == 'Brown Brown'
      end

      it 'should work for publishers' do
        allow(ENV).to receive(:[]).with("ISBNDB_API_KEY").and_return("123456789012345")
        stub_request(:get, "https://api.isbndb.com/publishers/Mondadori").to_return(:body => File.new('spec/responses/publishers.json'), :headers => {'Content-Type'=>'application/json'})

        expect { client.publishers('Mondadori') }.not_to raise_error

        @publishers = client.publishers('Mondadori')
        @publishers.size.should == 283

        @publisher = @publishers.first
        @publisher.name.should == 'Gai bu'
      end
    end

  end
end
