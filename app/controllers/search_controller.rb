class SearchController < ApplicationController
  
def search
  @value = params[:name]        #データを代入
  @datas = search_for(@value) #def search_forを実行(引数に検索ワードと検索方法)
end

private
  def search_for(value)
    Item.where(name: value).or(Item.where("name LIKE ?", "%#{value}%"))
  end
end
