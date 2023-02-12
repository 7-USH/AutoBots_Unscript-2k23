import requests
import json


class FCMessaging:
    def send_notif(self, deviceToken: str):
        serverToken = ''

        headers = {
            'Content-Type': 'application/json',
            'Authorization': 'key=' + serverToken,
        }

        body = {
            'notification': {'title': 'Sending push form python script',
                             'body': 'New Message'
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


fc_messaging = FCMessaging()
