json.array!(@tasks) do |task|
  json.extract! task, :id, :start_time, :end_time, :name, :description, :priority, :deadline
  json.url task_url(task, format: :json)
end
