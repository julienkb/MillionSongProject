import requests
from bs4 import BeautifulSoup
import re

f = open('links.txt', 'w');

years = ['2000', '2001', '2002', '2003', '2004', '2005', '2006', '2007', '2008', '2009', 
'2010', '2011', '2012', '2013'];

for year in years:
  print("Getting links for year: " + year);
  url = 'http://www.billboard.com/archive/charts/' + year + '/hot-100';
  r = requests.get(url);
  p = BeautifulSoup(r.content, 'html.parser');

  entries = p.find_all("tr");
  i = 0;
  for entry in entries:
    i = (i + 1) % 4
    if i == 0: 
      link = entry.find("a").get("href")
      f.write('http://www.billboard.com' + link + '\n');

f.close();