from sqlalchemy import Boolean, Column, String, Text, DateTime, Float, ForeignKey
from sqlalchemy.orm import relationship
from ..db.base_class import default_pk

from datetime import datetime
from ..db.base_class import Base
from backports.zoneinfo import ZoneInfo


class Bonds(Base):
    id = Column(String(36), primary_key=True, default=default_pk)
    company_name = Column(Text)
    last_price = Column(Float, nullable=False)
    bond_price = Column(Float, nullable=False)
    up_val = Column(Float)
    down_val = Column(Float)
    change = Column(String(24))
    volume = Column(Float)
    face_value = Column(Float)
    available = Column(Boolean)
