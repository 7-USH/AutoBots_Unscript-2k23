from sqlalchemy.orm import Session
from .base import CRUDBase
from ..models.bonds import Bonds
from datetime import datetime, timedelta
import jinja2
from integrations import mailer
from backports.zoneinfo import ZoneInfo

class CRUDBondsCreateRequest(CRUDBase):
    def create(
        self,
        db: Session,
        *,
        last_price: float, 
        bond_price: float,
        up_val: float, 
        down_val: float,
        change: float, 
        volume: float, 
        face_value: int,
        available: bool, 
    ):
        bond_obj = Bonds(
            last_price = last_price,
            bond_price = bond_price,
            up_val = up_val,
            down_val = down_val,
            change = change,
            volume = volume,
            face_value = face_value,
            available = available,
        )
        db.add(bond_obj)
        db.commit()
        db.refresh(bond_obj)
    
bonds = CRUDBondsCreateRequest()