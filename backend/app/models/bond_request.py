from sqlalchemy import Column, String, ForeignKey, DateTime, Float
from ..db.base_class import default_pk
from sqlalchemy.orm import relationship
from datetime import datetime

from ..db.base_class import Base
from backports.zoneinfo import ZoneInfo


class BondRequests(Base):
    id = Column(String(36), primary_key=True, default=default_pk)
    owner_email = Column(String(32), ForeignKey("users.email"), index=True)
    buyer_email = Column(String(32), ForeignKey("users.email"), index=True)
    user_bond_id = Column(String(36), ForeignKey("userbonds.id"), index=True)
    timestamp = Column(DateTime, default=str(
        datetime.now(tz=ZoneInfo('Asia/Kolkata'))))
    requested_price = Column(Float, nullable=False)

    owner = relationship("Users", foreign_keys=[owner_email])
    user_bond = relationship("UserBonds", foreign_keys=[user_bond_id])
    buyer = relationship("Users", foreign_keys=[buyer_email])
