from typing import Any, Dict

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ... import crud, models
from .. import deps

router = APIRouter()


@router.post("/create")
def create_user_bond(
    *,
    db: Session = Depends(deps.get_db),
    user_bond_dict: Dict,
    current_user: models.Users = Depends(deps.get_current_user)
) -> Any:
    user_obj = crud.user.get_by_email(db=db, email=current_user)
    response = crud.user_bonds.create(
        db=db, user_obj=user_obj, bond_dict=user_bond_dict)
    return response


@router.get("/get-bonds-by-user")
def get_user_bonds(
    *,
    db: Session = Depends(deps.get_db),
    current_user: models.Users = Depends(deps.get_current_user),
):
    user_bonds = crud.user_bonds.get_user_bonds(db=db, user_email=current_user)
    return user_bonds
