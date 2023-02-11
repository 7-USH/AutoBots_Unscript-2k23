from typing import Any, Dict

from PIL import Image
from io import BytesIO
import base64
import requests

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ... import crud, models
from .. import deps
import os

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
    success = crud.user.create(db, obj_in=user_in)
    return success


@router.get("/get-user-details")
def get_users(
    db: Session = Depends(deps.get_db),
    current_user: models.Users = Depends(deps.get_current_user)
):
    user_details = crud.user.get_user_details(db=db, email=current_user)

    return user_details


@router.post("/upload-aadhaar-image")
def upload_profile_image(
    db: Session = Depends(deps.get_db),
    *,
    profile_image_details: Dict
):
    print("#### Here")
    front_image = profile_image_details.get('aadhaar_image_front')
    back_image = profile_image_details.get('aadhaar_image_back')

    result_1 = crud.user.get_aadhaar_details(image=front_image, side='front')
    result_2 = crud.user.get_aadhaar_details(image=back_image, side='back')

    if result_1 and result_2:
        address = result_2.get('data')
        # print
        print(address)


new_dict = {
    "dob": "06/12/2002",
    "gender": "male",
    "name": "Amogh V Prabhu",
    "aadhaa_no": "226951622491",
    "address": "B-301 Navdurga CHS Sector-19 Nerul East Pin Code-400706 Navi Mumbai Thane Maharashtra 400615"
}
