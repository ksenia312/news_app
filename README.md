## Application for viewing news from different sources. 
Loads news using the API https://newsapi.org/.

### Screens
 1. All articles screen.
Contains a list of all news cards and how to filter them. 
Has a search bar and filter function to specify the search.

 2. Article screen.
Contains information about the news and a link to the source.

### Technical highlights
 - Uses BloC and ChangeNotifier for State Management.
 - Stores accesses in env file.
 - Uses custom errors for Error Handling.
 - Has a small Uikit for basic application components.
 - Dark and light theme, saved between sessions using SharedPreferences.

To run, use `tool/run.sh`. It picks variables from the `.env` and runs the application.
But find the .env file first)