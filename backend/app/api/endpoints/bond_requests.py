from typing import Any, Dict

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ... import crud, models
from .. import deps

router = APIRouter()



@router.post("/create-request")
def create_request(
    *,
    db: Session = Depends(deps.get_db),
    user_bond_dict: Dict,
    current_user: models.Users = Depends(deps.get_current_user),
):
    request_obj = crud.bond_requests.create(
        db=db,
        bond_id=user_bond_dict.get('bond_id'),
        buyer_email=current_user,
        requested_price=user_bond_dict.get('requested_price')
    )
    return request_obj


@router.get("/get-requests-by-owner")
def get_requests_by_owner(
    *,
    db: Session = Depends(deps.get_db),
    current_user: models.Users = Depends(deps.get_current_user),
):
    user_bond_requests = crud.bond_requests.get_requests_by_user(
        db=db, user_email=current_user)
    return user_bond_requests


@router.post("approve-request")
def approve_request(
    *,
    db: Session = Depends(deps.get_db),
    current_user: models.Users = Depends(deps.get_current_user),
    bond_request_dict: Dict
):
    response = crud.bond_requests.approve_bond_request(
        db=db, bond_request_id=bond_request_dict.get('bond_request_id'), owner_email=current_user)
    return response
