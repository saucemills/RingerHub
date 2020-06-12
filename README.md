# RingerHub

RingerHub was written in Swift 5 completely programmatically. The app consists of 3 main tabs
that all pull information to display from 3 main sources, all connected to the Ringer network,
of which I am a huge fan.

1. News feed: This pulls information from the Ringer website's Atom RSS feed and displays the article title,
date, and author in a table format. If the user taps the article, the app will then take you to the
Safari version of the full article. The rss feed for the Ringer only shows the last 10 articles. With more
time, I would like to web scrape the actual website to display more current articles.

2. Youtube: This feed displays content from the Ringer's YouTube channel. The app pulls from Youtube's API
to display the main thumbnail, title and date published of the video and takes you to the actual video upon
tapping on it.

3. Podcast: This pulls information from the Bill Simmons Podcast RSS feed and displays the podcast image,
podcast title, and date published. Originally when I made this app, it was pulling from Spotify's API but the
API key expired after 24 hours so I switched it to the actual RSS feed.
