from typing import Any, Dict, List
import openai
import re

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ... import crud, models
from .. import deps
from integrations import scraper

router = APIRouter()


@router.get("/live-bonds")
def get_live_bonds(
    *,
    db: Session = Depends(deps.get_db),
) -> List:
    live_bonds = scraper.get_current_bonds()
    if live_bonds:
        return live_bonds[1:]
    raise HTTPException(
        status_code=503,
        detail="Internal Server Error"
    )


@router.get("/news")
def get_live_bonds(
    *,
    db: Session = Depends(deps.get_db),
) -> List:
    news = scraper.get_news()
    if news:
        return news
    raise HTTPException(
        status_code=503,
        detail="Internal Server Error"
    )

@router.post("/ask-question")
def get_reply(*,
    db: Session = Depends(deps.get_db),
    question: Dict,

) -> Dict:
    openai.api_key = "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"
    question = question.get('question')
    print(question)
    response = openai.Completion.create(
        model="text-davinci-003",
        prompt=question,
        temperature=0,
        max_tokens= 1000,
    )
    return {"answer": response.choices[0].text.strip("\n")}
