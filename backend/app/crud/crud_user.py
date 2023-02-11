from typing import Dict, Optional, Any, List
from sqlalchemy.orm import Session
from ..core.security import get_password_hash, verify_password
import random
from .base import CRUDBase
from ..models.users import Users
from integrations import mailer
from datetime import datetime
from app import crud
import jinja2
import uuid
from ..core.config import settings

import os

from PIL import Image
from io import BytesIO
import base64
import requests

import random
from backports.zoneinfo import ZoneInfo


class CRUDUser(CRUDBase):
    def get_by_email(self, db: Session, *, email: str) -> Optional[Users]:
        return db.query(Users).filter(Users.email == email).first()

    def create(self, db: Session, *, obj_in: Dict) -> Any:
        db_obj = Users(
            email=obj_in.get("email"),
            hashed_password=get_password_hash(obj_in.get('password')),
            full_name=obj_in.get('full_name'),
            is_active=False,
        )
        db.add(db_obj)
        db.commit()
        db.refresh(db_obj)

        self.send_verification_otp(db=db, user_obj=db_obj)

        user_dict = db_obj.__dict__
        user_dict.pop('hashed_password')
        return user_dict

    def get_users(self, db: Session) -> List[Users]:
        db_users = db.query(Users).all()
        return db_users

    def authenticate(self, db: Session, *, email: str, password: str) -> Optional[Users]:
        user = self.get_by_email(db, email=email)
        if not user:
            return None
        if not verify_password(password, user.hashed_password):
            return None
        return user

    def is_active(self, user: Users) -> bool:
        return user.is_active

    def update(self, db: Session, *, db_obj: Users, obj_in: Dict[str, Any]) -> Users:
        if isinstance(obj_in, dict):
            update_data = obj_in
        if update_data.get("password", None):
            hashed_password = get_password_hash(update_data["password"])
            del update_data["password"]
            update_data["hashed_password"] = hashed_password
        return super().update(db, db_obj=db_obj, obj_in=update_data)

    def get_user_details(self, db: Session, email: str) -> Dict[str, Any]:
        user_obj = crud.user.get_by_email(db=db, email=email)
        user_dict = user_obj.__dict__
        user_dict.pop('hashed_password')
        return user_dict

    def activate_user(self, db: Session, user_obj: Users, activation_code: int) -> bool:
        # minutes = divmod(
        #     (datetime.now(tz=ZoneInfo('Asia/Kolkata')) - user_obj.registration_date).total_seconds(), 60)[0]
        success = user_obj.activation_code == activation_code
        if success:
            setattr(user_obj, 'is_active', True)
            db.add(user_obj)
            db.commit()
            db.refresh(user_obj)
        return success

    def send_verification_otp(self, db: Session, user_obj: Users) -> Users:
        activation_code = random.randint(1000, 9999)
        with open("templates/registration-successful.html", "r") as f:
            template_string = f.read()
        template = jinja2.Template(template_string)
        registration_template = template.render(
            activation_code=activation_code, full_name=user_obj.full_name)
        response = mailer.send_email(
            receiver_email=user_obj.email, subject="OTP for Login", email_content=registration_template)
        print(response)
        setattr(user_obj, 'activation_code', activation_code)
        db.add(user_obj)
        db.commit()
        db.refresh(user_obj)
        return user_obj

    def get_aadhaar_details(self, image: str, side: str):
        im = Image.open(BytesIO(base64.b64decode(image)))
        file_name = str(uuid.uuid4()) + '-image.png'
        im.save(file_name)

        url = f"https://nationalapi.docsumo.com/api/v1/national/extract/?side={side}&save_data=false&return_redacted=false&fraud_check=true"

        with open(file_name, 'rb') as f:
            x = requests.post(url, headers={
                "X-API-KEY": settings.X_API_KEY}, files={'File': f})
            # print(x.status_code)
            # print(x.text)
        os.remove(file_name)

        if x.status_code == 200:
            return x.text
        return False


user = CRUDUser()
