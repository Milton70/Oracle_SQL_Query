require 'rufus-scheduler'

	s = Rufus::Scheduler.singleton

	s.every '1h' do
		files = Dir.glob("#{Rails.root}/tmp/*.xlsx")
		files.each do |file|
			File.delete(file)
		end
	end