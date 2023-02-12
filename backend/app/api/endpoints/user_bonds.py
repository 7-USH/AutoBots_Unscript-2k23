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
    if crud.bonds.is_bond_owned(db=db, bond_id=user_bond_dict.get('bond_id')):
        response = crud.bond_requests.create(db=db, bond_id=user_bond_dict.get(
            'bond_id'), buyer_email=current_user, requested_price=user_bond_dict.get('requested_price'))
        return response
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


@router.put("/sell-user-bond")
def send_user_bond(
    *,
    db: Session = Depends(deps.get_db),
    current_user: models.Users = Depends(deps.get_current_user),
    user_bond_dict: Dict
):
    user_bond_obj = crud.user_bonds.sell_user_bond(
        db=db, user_bond_id=user_bond_dict.get('user_bond_id'), user_email=current_user)
    return user_bond_obj
