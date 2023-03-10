
from typing import Dict
from sqlalchemy.orm import Session
from .base import CRUDBase
from app.models import Bonds, UserBonds, BondRequests

from integrations import fc_messaging
from app import crud


class CRUDBondRequests(CRUDBase):
    def create(self, db: Session, buyer_email: str, requested_price: float, bond_id: str):
        user_bond_obj = db.query(UserBonds).filter(
            UserBonds.id == bond_id).first()
        if not user_bond_obj:
            return False
        bond_request_obj = BondRequests(
            owner_email=user_bond_obj.user_email,
            buyer_email=buyer_email,
            user_bond_id=user_bond_obj.id,
            requested_price=requested_price
        )
        db.add(bond_request_obj)
        db.commit()
        db.refresh(user_bond_obj)

        buyer_obj = crud.user.get_by_email(db=db, email=buyer_email)

        fc_messaging.send_notif(deviceToken=user_bond_obj.user.device_token,
                                buyer_name=buyer_obj.full_name, company_name=user_bond_obj.bond.company_name)
        fc_messaging.send_email_bond_status(buyer_obj.full_name,user_bond_obj.bond.company_name,user_bond_obj.user.email)
        return bond_request_obj

    def get_requests_by_user(self, db: Session, user_email: str):
        user_bond_requests = db.query(BondRequests).filter(
            BondRequests.owner_email == user_email).all()
        return user_bond_requests

    def approve_bond_request(self, db: Session, bond_request_id: str, owner_email: str):
        bond_request_obj = db.query(BondRequests).filter(
            BondRequests.owner_email == owner_email).filter(BondRequests.id == bond_request_id).first()
        if bond_request_obj is None:
            return False
        buyer_obj = crud.user.get_by_email(
            db=db, email=bond_request_obj.buyer_email)
        owner_obj = crud.user.get_by_email(db=db, email=owner_email)
        if not buyer_obj or not owner_obj:
            return False
        updated_buyer_acc_bal = buyer_obj.account_balance - \
            bond_request_obj.requested_price
        updated_owner_acc_bal = owner_obj.account_balance + \
            bond_request_obj.requested_price

        setattr(buyer_obj, 'account_balance', updated_buyer_acc_bal)
        db.add(buyer_obj)
        setattr(owner_obj, 'account_balance', updated_owner_acc_bal)
        db.add(owner_obj)
        bond_id = bond_request_obj.user_bond.bond_id
        bond_request_obj.user_bond.delete()
        buyer_bond_obj = UserBonds(
            user_email=buyer_obj.email,
            selling_status="Private",
            bond_id=bond_id
        )
        db.add(buyer_bond_obj)

        bond_obj = crud.bonds.get_bond_by_id(db=db, bond_id=bond_id)
        setattr(bond_obj, 'available', True)

        db.add(bond_obj)
        db.commit()

        db.refresh(owner_obj)
        return owner_obj


bond_requests = CRUDBondRequests()
