import requests
from bs4 import BeautifulSoup
import re
from sets import Set

links = open('links.txt', 'r');
f = open('billboard.csv', 'w');
allSongs = Set();

for link in links:
  r = requests.get(link[0:-1]);
  print("Reading from " + link);
  p = BeautifulSoup(r.content, 'html.parser');
  songsInfo = p.find_all("div", "row-title");

  for song in songsInfo:
    title = song.find('h2').text;
    title = re.sub('[\n\t]', '', title);
    artist = song.find('h3').text;
    artist = re.sub('[\n\t]', '', artist);
    if (title, artist) not in allSongs:
      allSongs.add((title, artist))
      f.write('"' + title + '","' + artist + '"\n');

f.close();
