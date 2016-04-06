import mechanize
import bs4
import time
import re
import random
import pandas
import traceback


br = mechanize.Browser()
br.set_handle_robots( False )
br.addheaders = [('User-agent', 'Mozilla/5.0 (Linux; Android 5.0.2; HTC One_M8 Build/LRX22G) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.48 Mobile Safari/537.36')]

df = pandas.read_csv('moviescsv.csv')

prodids = list(set(df['product_productid']))[:100]


for ppid in prodids:
	if type(ppid) == str:
		if "." in ppid and len(ppid) == 11:
			pid = ppid.replace('.0','')
			pid = '0' + pid
		elif "." in ppid:
			pid = ppid.replace('.0','')
		else:
			pid = ppid
		try:
			a = br.open( "http://www.amazon.com/exec/obidos/ASIN/" + pid )
			soup = bs4.BeautifulSoup(a.read())
			title = soup.title.text
			stars = soup.find("div",{"id":"rating-stars"})
			if stars == None:
				stars = soup.find('span',{'class':'a-icon-alt'})
			stars = stars.text
			stars = re.sub(r"stars.*","",stars)
			stars = stars.replace('\n','')
			stars = stars.strip()
			stars = stars.replace('out of 5','')
			stars = stars.strip()
			stars = float(stars)
			print pid, title, stars
		except:
			print pid
			traceback.print_exc()
			# print soup


