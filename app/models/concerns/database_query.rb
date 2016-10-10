module DatabaseQuery
  def latest
    order created_at: :desc
  end

  def sort_by_name
    order name: :asc
  end

  def sort_by_title
    order title: :asc
  end
end
