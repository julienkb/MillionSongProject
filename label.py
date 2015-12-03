import csv
from sets import Set
import re

import csv

f = open('billboard.csv', 'r');
reader = csv.reader(f);
hitsongs = list(reader);
f.close();

f = open('songTitles.csv', 'r');
reader = csv.reader(f);
songs = list(reader);
f.close();

f = open('match_indices.csv', 'w');
f.write("Song title (billboard), Song title (database), Song artist (billboard), \
    song artist (database), billboard index, database index\n");
labels = list();
checkWords = ["Version", "Live", "Instrumental", "LP", "Album", "instr.", 
              "Remaster", "remaster", "album", "Mix", "version", "feat.",
              "Feat.", "featuring", "Featuring"];
artistDelim = [',', '(', ';', '&', "feat.", '/', "Feat.", 'featuring', 'Featuring'];
count = 0;
for s in range(0, len(songs)):
  title = (songs[s][0]);
  """ Remove unnecessary words. """
  for word in checkWords:
    if word in title:
      endIndex = title.rfind('(');
      if endIndex == -1:
        endIndex = title.rfind('[');
      if endIndex == -1:
        endIndex = title.rfind(word);
      if endIndex != -1:
        title = title[0:endIndex - 1];
  title = title.rstrip();

  """ Get only the first artist, then check """
  artist = songs[s][1];
  for delim in artistDelim:
    if delim in artist:
      artist = artist[0:artist.find(delim)];
  artist = artist.rstrip();

  matches = [(title in x[0]) for x in hitsongs];
  for m in range(0, len(matches)):
    if matches[m]:
      if artist in hitsongs[m][1]:
        print(artist + ',' + title);
        #f.write('"{}", "{}", "{}", "{}", {}, {} \n'.format (hitsongs[m][0], songs[s][0],
        #          hitsongs[m][1], songs[s][1], m, s));
        f.write("{}\n".format(s));
        count += 1;
        break;

f.close();
print("Number of matches: %d" % count);