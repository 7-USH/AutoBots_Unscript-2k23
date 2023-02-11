from sqlalchemy import Column, String, ForeignKey, DateTime, Float
from ..db.base_class import default_pk
from sqlalchemy.orm import relationship

from ..db.base_class import Base


class UserBonds(Base):
    user_email = Column(String(32), ForeignKey("users.email"), index=True)
    bond_id = Column(String(36), ForeignKey("bonds.id"), index=True)

    user = relationship("Users", foreign_keys=[user_email])
    bond = relationship("Bonds", foreign_keys=[bond_id])
