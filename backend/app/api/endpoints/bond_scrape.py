from typing import Any, Dict, List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ... import crud, models
from .. import deps
from integrations import scraper

router = APIRouter()


@router.post("/live-bonds")
def get_live_bonds(
    *,
    db: Session = Depends(deps.get_db),
) -> List:
    live_bonds = scraper.get_current_bonds()
    return live_bonds
