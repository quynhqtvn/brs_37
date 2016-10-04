module DatabaseQuery
  def latest
    order created_at: :desc
  end
end
