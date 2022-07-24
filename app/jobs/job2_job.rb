class Job2Job < ApplicationJob
  queue_as :default 

  around_perform :around_job2

  def perform(job = "job3")
    t = Time.now
    puts "+++++++++++++++++++"
    puts "a defalut #{job} : #{t.strftime("%X")}"
    puts "+++++++++++++++++++"
  end

  private
  def around_job2
    puts "+++++++++++++++++++"
    puts "before job2"
  yield
    puts "after job2"
    puts "+++++++++++++++++++"
  end
end
