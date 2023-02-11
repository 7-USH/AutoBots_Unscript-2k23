from typing import Any, Dict

from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ... import crud, models
from .. import deps
import os
import json

router = APIRouter()


@router.post("/register")
def create_user(
    *,
    db: Session = Depends(deps.get_db),
    user_in: Dict,
) -> Any:
    """
    Create new user.
    """
    user = crud.user.get_by_email(db, email=user_in.get("email"))
    if user:
        raise HTTPException(
            status_code=400,
            detail="The user with this username already exists in the system.",
        )
    print("#### Here")
    front_image = user_in.get('aadhaar_image_front')
    back_image = user_in.get('aadhaar_image_back')

    result_1 = crud.user.get_aadhaar_details(image=front_image, side='front')
    result_2 = crud.user.get_aadhaar_details(image=back_image, side='back')

    if result_1 and result_2:
        result_1 = json.loads(result_1)
        result_2 = json.loads(result_2)

        address = result_2['data']['address']['value']
        dob = datetime.strptime(result_1['data']['dob']['value'], '%d/%m/%Y')
        gender = result_1['data']['gender']['value']
        aadhaar_no = result_1['data']['no']['value']
        full_name = result_1['data']['name']['value']
        print(address)
        print(dob)
        print(gender)
        print(aadhaar_no)
        print(full_name)

        success = crud.user.create(
            db=db,
            aadhaar_no=aadhaar_no,
            address=address,
            dob=dob,
            email=user_in.get("email"),
            full_name=full_name,
            password=user_in.get('password'),
            gender=gender
        )
        return success
    else:
        raise HTTPException(
            status_code=503,
            detail="Internal Serveer Error"
        )


@router.get("/get-user-details")
def get_users(
    db: Session = Depends(deps.get_db),
    current_user: models.Users = Depends(deps.get_current_user)
):
    user_details = crud.user.get_user_details(db=db, email=current_user)

    return user_details


@router.put("/deposit-amount")
def get_users(
    txn_details: Dict,
    db: Session = Depends(deps.get_db),
    current_user: models.Users = Depends(deps.get_current_user),
):
    deposit_amount = txn_details.get('deposit_amount')
    user_obj = crud.user.deposit_amount(
        db=db, deposit_amount=deposit_amount, user_email=current_user)
    return user_obj
