import requests
from bs4 import BeautifulSoup
import re


class Scraper:
    def get_current_bonds(self):
        try:
            r = requests.get(
                "https://www.moneycontrol.com/fixed-income/bonds/listed-bonds/")

        except Exception as e:
            print(e)
            return False

        soup = BeautifulSoup(r.content, 'html.parser')
        result = soup.find(id='datadiv_1')

        li = []
        for trs in result.find_all('tr'):
            tag = trs.find('a')
            if tag is not None:
                val = trs.find_all('td')
                curr_list = []
                if val is not None and val[0].text != 'COMPANY NAME':
                    for x in val:
                        curr_list.append(x.text)
                    curr_bond = {
                        'company_name': curr_list[0],
                        'last_price': float(re.sub(",", "", curr_list[1])),
                        'change':  curr_list[2],
                        'open': float(re.sub(",", "", curr_list[3])),
                        'high': float(re.sub(",", "", curr_list[4])),
                        'low': float(re.sub(",", "", curr_list[5])),
                        'volume': float(re.sub(",", "", curr_list[6])),
                        'face_value': float(re.sub(",", "", curr_list[7]))
                    }
                    li.append(curr_bond)
        return li[1:]

    def get_news(self):
        try:
            html = requests.get(
                'https://economictimes.indiatimes.com/topic/bond-market')

        except Exception as e:
            print(e)
            return False

        soup = BeautifulSoup(html.text, "html5lib")

        span_list = soup.find(id='categorywiseTop').find_all("span")
        new_items = [span_list[i].find_all("img")
                     for i in range(len(span_list))]
        new_items[0][0]['data-original']
        soup.find(id='categorywiseTop').find_all(
            "div", {'class': 'syn'})[0].string

        news_list = [
            {
                'title': new_items[i][0]['alt'],
                'image':new_items[i][0]['data-original'],
                'time':soup.find(id='categorywiseTop').find_all("time")[i].string,
                'desc':soup.find(id='categorywiseTop').find_all("div", {'class': 'syn'})[i].string
            } for i in range(len(new_items))
        ]

        all_list = soup.find(id='categorywise').find_all("ul")
        new_all_list = all_list[1:][0].find_all('li')[0].find_all("div")

        for i in range(len(new_all_list)):
            try:
                news_list.append({
                    'title': new_all_list[i].find_all("img")[0]['alt'],
                    'image': new_all_list[i].find_all("img")[0]['data-original'],
                    'desc': new_all_list[i].find_all("div", {'class': "syn"})[0].string,
                    'time': new_all_list[i].find_all("div", {'class': "contentD"})[0].find_all("time")[0].string
                }
                )
            except:
                pass
        return news_list


scraper = Scraper()
