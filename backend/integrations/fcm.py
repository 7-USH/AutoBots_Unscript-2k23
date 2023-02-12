import jinja2
import requests
import json
from app.core.config import settings

from integrations.mails import Mailer


class FCMessaging:
    def send_notif(self, deviceToken: str, buyer_name: str, company_name: str):
        serverToken = settings.FCM_SERVER_TOKEN

        headers = {
            'Content-Type': 'application/json',
            'Authorization': 'key=' + serverToken,
        }

        body = {
            'notification': {
                'title': 'New Bond Requests',
                'body': 'You have an request from {} to buy a bond of {}'.format(buyer_name, company_name)
            },
            'to': deviceToken,
            'priority': 'high',
        }
        response = requests.post(
            "https://fcm.googleapis.com/fcm/send", headers=headers, data=json.dumps(body))
        print(response.status_code)

        print(response.json())
        return response.json()
    
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
