from sqlalchemy import Column, String, ForeignKey, DateTime, Float
from ..db.base_class import default_pk
from sqlalchemy.orm import relationship
from datetime import datetime

from ..db.base_class import Base
from backports.zoneinfo import ZoneInfo


class UserBonds(Base):
    id = Column(String(36), primary_key=True, default=default_pk)
    user_email = Column(String(32), ForeignKey("users.email"), index=True)
    bond_id = Column(String(36), ForeignKey("bonds.id"), index=True)
    timestamp = Column(DateTime, default=str(
        datetime.now(tz=ZoneInfo('Asia/Kolkata'))))
    selling_status = Column(String(36))  # Up for selling / Private / Sold

    user = relationship("Users", foreign_keys=[user_email])
    bond = relationship("Bonds", foreign_keys=[bond_id])
