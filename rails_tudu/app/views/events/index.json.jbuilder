json.array!(@events) do |event|
  json.extract! event, :id, :start_time, :end_time, :name, :description
end
