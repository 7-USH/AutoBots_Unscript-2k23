from sqlalchemy.orm import Session
from .base import CRUDBase
from ..models import Bonds, UserBonds
import jinja2
from integrations import mailer
from backports.zoneinfo import ZoneInfo
from app import crud


class CRUDBondsCreateRequest(CRUDBase):
    def create(
        self,
        db: Session,
        *,
        company_name: str,
        last_price: float,
        bond_price: float,
        up_val: float,
        down_val: float,
        change: str,
        volume: float,
        face_value: float,
        available: bool,
    ):
        print(type(change))
        bond_obj = Bonds(
            company_name=company_name,
            last_price=last_price,
            bond_price=bond_price,
            up_val=up_val,
            down_val=down_val,
            change=change,
            volume=volume,
            face_value=face_value,
            available=available,
        )
        db.add(bond_obj)
        db.commit()
        db.refresh(bond_obj)

        return True

    def get(self, db: Session):
        return db.query(Bonds).filter(Bonds.available == True).all()

    def get_bond_by_id(self, db: Session, bond_id: str):
        bond_obj = db.query(Bonds).filter(Bonds.id == bond_id).first()
        return bond_obj

    def is_bond_owned(self, db: Session, bond_id: str):
        user_bond_obj = db.query(UserBonds).filter(
            UserBonds.bond_id == bond_id).first()
        return user_bond_obj


bonds = CRUDBondsCreateRequest()
