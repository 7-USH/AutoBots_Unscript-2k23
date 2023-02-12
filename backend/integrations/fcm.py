import requests
import json
from app.core.config import settings


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


fc_messaging = FCMessaging()
