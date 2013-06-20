nepTune-Music
=============

# Development workflow
The ```master``` branch reflects what is currently deployed/in production. The ```develop``` branch is the central repository for our day-to-day development, and ```develop``` will get merged into ```master``` right before we push. This works for now, as we aren't pushing code live all that often. Once we have a live app up, we'll likely be working straight from ```master``` to minimize overhead. 

Create branches for every new thing, and to avoid tons of conflicts and nastier things (like detached head), each branch should really only be the work of one developer. Commit often, and make sure to sync/push the branch every so often as well. Merge your branch into ```develop``` at least once a day.

And as always, *don't commit broken code*. Or the Octocat will get you. Or something.

# Initial setup
Our app is currently routed through a ```beta``` subdomain, and will be deployed as such for the near future. Therefore, we have to map a ```beta``` subdomain on any main domain to ```localhost``` to test on our system. This can be done by editing ```/etc/hosts```, which requires special permissions. Sublime Text, Textmate, and BBEdit on the mac can do this; in Windows, you can run Notepad with administrator privileges to achieve the same thing. 

The hosts entries you'll have to  make (the should be on separate lines):

```127.0.0.1 beta.neptune.com
127.0.0.1 neptune.com
127.0.0.1 www.neptune.com```

Next, you'll have to set up your databases. We're using Postgres, because Heroku uses it in production and it's best to keep things the same as much as possible. There's a [mac app](http://postgresapp.com) which makes it really easy to run Postgres. In Terminal, make sure you ```cd``` to the Rails app's root directory, and run ```rake db:create``` then ```rake db:migrate```. Finally, run ```rake admin:fill_db``` to create sample database entries. This task is in ```lib/tasks/fill_db.rake``` if you want to check it out. *Note that the rake task wipes the database when it runs to prevent problems with old associations and ids*. 

Using this setup, you can access the app at ```beta.neptune.com:3000```. An artist's page is at ```beta.neptune.com:3000/thepianoguys```, and from there it links to other pages as well. 

*This Readme file will be updated as necessary. Last updated on June 20th, 2013*
