import jinja2
import requests
import json

from integrations.mails import Mailer


class FCMessaging:
    def send_notif(self, deviceToken: str, buyer_name: str, company_name:str):
        serverToken = 'AAAAqBGiGgY:APA91bF25esPpOFtueazJzVwxMupoW-JBS6LN7oh6k9D3Jo4Ls0HjimmO_EZstCcGcZufjjwb00XTwObfz3gU-sDpqncfmAk-o-NY_cw2RPK1L2k8m4cTx2NBSL-CBIObW0Zh3PK4db_'

        headers = {
            'Content-Type': 'application/json',
            'Authorization': 'key=' + serverToken,
        }

        body = {
            'notification': {'title': 'New Bond Requests',
                             'body': 'You have an request from {} to buy a bond of {}'.format(buyer_name,company_name)
                             },
            'to':
            deviceToken,
                'priority': 'high',
                #   'data': dataPayLoad,
        }
        response = requests.post(
            "https://fcm.googleapis.com/fcm/send", headers=headers, data=json.dumps(body))
        print(response.status_code)

        print(response.json())
    
    def send_email_bond_status(self, buyer_name: str, company_name: str, user_email:str):
        with open("templates/bond-request.html", "r") as f:
            template_string = f.read()
        template = jinja2.Template(template_string)
        registration_template = template.render(
            buyer_name=buyer_name, company_name=company_name)
        response = Mailer.send_email(
            receiver_email=user_email, subject="New request for bonds.", email_content=registration_template)
        print(response)

fc_messaging = FCMessaging()
