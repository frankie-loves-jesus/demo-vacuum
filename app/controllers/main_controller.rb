class MainController < ApplicationController
  def index
    request = Vacuum.new('GB')
    
    request.configure(
      aws_access_key_id: 'ABCDEFGHIJKLMNOPQRSTU',
      aws_secret_access_key: '<long key>',
      associate_tag: 'lipsum-20'
    )
    
    params = {
      'SearchIndex' => 'All',
      'Keywords'=> 'women',
      'ResponseGroup' => "ItemAttributes,Images"
    }

    raw_products = request.item_search(query: params)
    hashed_products = raw_products.to_h

    @products = []
    
    hashed_products['ItemSearchResponse']['Items']['Item'].each do |item|
      product = OpenStruct.new
      product.name = item['ItemAttributes']['Title']
      product.url = item['DetailPageURL']
      product.image_url = item['LargeImage']['URL']
      
      @products << product 
    end

  end
end

