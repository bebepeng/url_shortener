class UrlRepository

  def initialize(db)
    @url_table = db[:urls]
  end

  def insert(url, vanity)
    if !vanity.empty?
      @url_table.insert(:original_url => url, :vanity => vanity)
      vanity
    else
      @url_table.insert(:original_url => url, :vanity => nil)
    end
  end

  def add_visit(identifier)
    if identifier.to_i.to_s == identifier
      @url_table.where(:id => identifier).update(:visits => get_visits(identifier) + 1)
    else
      @url_table.where(:vanity => identifier).update(:visits => get_visits(identifier) + 1)
    end
  end

  def get_visits(identifier)
    if identifier.to_i.to_s == identifier
      @url_table[:id => identifier][:visits]
    else
      @url_table[:vanity => identifier][:visits]
    end
  end

  def get_url(identifier)
    if identifier.to_i.to_s == identifier
      @url_table[:id => identifier.to_i][:original_url]
    else
      @url_table[:vanity => identifier][:original_url]
    end
  end

  def has_vanity?(vanity)
    !@url_table[:vanity => vanity].nil?
  end
end