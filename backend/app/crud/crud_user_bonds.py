
from typing import Dict
from sqlalchemy.orm import Session
from .base import CRUDBase
from app.models import Bonds, UserBonds, Users
from app import crud


class CRUDUserBonds(CRUDBase):
    def create(self, db: Session, user_obj: Users, bond_dict: Dict):
        bond_obj = db.query(Bonds).filter(
            Bonds.id == bond_dict.get('bond_id')).first()
        if bond_obj and bond_obj.available:
            user_bond_obj = UserBonds(
                user_email=user_obj.email,
                bond_id=bond_obj.id,
                selling_status="Private"
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

    def get_user_bonds(self, db: Session, user_email: str):
        user_bonds = db.query(UserBonds).filter(
            UserBonds.user_email == user_email).all()
        bonds_list = []
        for bond in user_bonds:
            bond_dict = bond.__dict__
            bond_details = crud.bonds.get_bond_by_id(
                db=db, bond_id=bond.bond_id)
            bond_dict['bond_details'] = bond_details
            bonds_list.append(bond_dict)
        return bonds_list

    def sell_user_bond(self, db: Session, user_email: str, user_bond_id: str):
        user_bond_obj = db.query(UserBonds).filter(
            UserBonds.user_email == user_email).filter(UserBonds.id == user_bond_id).first()
        setattr(user_bond_obj, 'selling_status', 'Up for sale')
        db.add(user_bond_obj)

        setattr(user_bond_obj.bond, 'available', True)
        db.add(user_bond_obj.bond)
        db.commit()
        db.refresh(user_bond_obj)

        return user_bond_obj

    def get_bonds_for_sale(self, db: Session):
        user_bonds = db.query(UserBonds).filter(
            UserBonds.selling_status == "Up for selling").all()
        user_bonds_list = []
        for bond in user_bonds:
            bond_dict = bond.__dict__
            bond_details = crud.bonds.get_bond_by_id(
                db=db, bond_id=bond.bond_id)
            bond_dict['bond_details'] = bond_details
            user_bonds_list.append(bond_dict)
        return user_bonds_list


user_bonds = CRUDUserBonds()
