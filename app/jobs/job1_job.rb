class Job1Job < ApplicationJob
  queue_as :default
  

  def perform(job = ["job3"])
    t = Time.now
    puts "+++++++++++++++++++"
    puts "a defalut #{job} : #{t.strftime("%X")}"
    puts "+++++++++++++++++++"
  end
end
