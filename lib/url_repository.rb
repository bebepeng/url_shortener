class UrlRepository

  def initialize(table)
    @url_table = table
  end

  def insert(url)
    @url_table.insert(:original_url => url)
  end

  def add_visit(id)
    @url_table.where(:id => id).update(:visits => get_visits(id) + 1)
  end

  def get_visits(id)
    @url_table[:id => id][:visits]
  end

  def get_url(id)
    @url_table[:id => id][:original_url]
  end
end