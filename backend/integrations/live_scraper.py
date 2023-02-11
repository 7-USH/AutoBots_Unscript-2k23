import requests
from bs4 import BeautifulSoup


class Scraper:
    def get_current_bonds(self):
        try:
            r = requests.get(
                "https://www.moneycontrol.com/fixed-income/bonds/listed-bonds/")

        except Exception as e:
            print(e)

        soup = BeautifulSoup(r.content, 'html.parser')
        result = soup.find(id='datadiv_1')

        li = []
        for trs in result.find_all('tr'):
            tag = trs.find('a')
            if tag is not None:
                val = trs.find_all('td')
                curr_list = []
                if val is not None:
                    for x in val:
                        curr_list.append(x.text)
                    curr_bond = {
                        'company_name': curr_list[0],
                        'last_price': curr_list[1],
                        'change': curr_list[2],
                        'open': curr_list[3],
                        'high': curr_list[4],
                        'low': curr_list[5],
                        'volume': curr_list[6],
                        'face_value': curr_list[7]
                    }
                    li.append(curr_bond)
        return li


scraper = Scraper()
