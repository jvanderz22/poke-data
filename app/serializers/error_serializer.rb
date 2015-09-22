class ErrorSerializer < ActiveModel::Serializer
  attributes :id, :pointer, :detail, :status

  private

  def id
    1
  end

  def pointer
    object.pointer
  end

  def detail
    object.detail
  end

  def status
    object.status
  end
end
