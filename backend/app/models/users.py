from sqlalchemy import Boolean, Column, String, Text, DateTime, Float, ForeignKey
from sqlalchemy.orm import relationship

from datetime import datetime
from ..db.base_class import Base
from backports.zoneinfo import ZoneInfo


class Users(Base):
    email = Column(String(32), unique=True, index=True,
                   primary_key=True, nullable=False)
    full_name = Column(String(64), nullable=False, index=True)
    hashed_password = Column(String(512))
    is_active = Column(Boolean(), default=False)
    activation_code = Column(Float)
    registration_date = Column(DateTime, default=str(
        datetime.now(tz=ZoneInfo('Asia/Kolkata'))))
    # address = Column(Text)
    # aadhaar_no = Column(String(12), nullable=False, index=True, unique=True)
    # dob = Column(DateTime)
    # gender = Column(String(24))
