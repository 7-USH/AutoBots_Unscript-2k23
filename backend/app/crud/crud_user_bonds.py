
from typing import Dict
from sqlalchemy.orm import Session
from .base import CRUDBase
from app.models import Bonds, UserBonds, Users


class CRUDUserBonds(CRUDBase):
    def create(self, db: Session, user_obj: Users, bond_dict: Dict):
        bond_obj = db.query(Bonds).filter(
            Bonds.id == bond_dict.get('bond_id')).first()
        if bond_obj and bond_obj.available:
            user_bond_obj = UserBonds(
                user_email=user_obj.email,
                bond_id=bond_obj.id
            )
            db.add(user_bond_obj)
            db.commit()
            db.refresh(user_bond_obj)

            updated_balance = user_obj.account_balance - bond_obj.bond_price
            setattr(user_obj, 'account_balance', updated_balance)
            db.add(user_obj)

            setattr(bond_obj, 'available', False)
            db.add(bond_obj)
            db.commit()
            db.refresh(user_obj)

            return user_bond_obj

        return False

    def get_user_bonds(self, db: Session, user_email: str):
        user_bonds = db.query(UserBonds).filter(
            UserBonds.user_email == user_email).all()
        return user_bonds


user_bonds = CRUDUserBonds()
