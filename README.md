Rerun Task
==========


Rerun task is gem for checking if your rake task was executed successfully. You have to place all your rake code to `WatchProcess.new("task_name").call{}`. I write below some examples.

Examples
====
	task :dummy_task => :environment do
		WatchProcess.new("task_name").call do
			# your code write here 		
		end
	end
	
Now if you run rake task, then is created pid-files of your process. To your crontab place task, which every 5th minute check if all task done successfully.

non-rails app
====
If you use as non-rails app, you have to copy /bin/rerun_task_crontab.rb from gem to your app

	*/5 * * * * ruby /path/to/the/your-app/bin/rerun_task_crontab.rb

rails app
====
	
If you use it in rails app, you can use rails runner

	*/5 * * * * cd path/to/your-app; bundle exec rails runner RerunTask::UnfinishedRunner.crontab_retry
	
Notes	
====
In this version is not allowed to run same process in same time.	
