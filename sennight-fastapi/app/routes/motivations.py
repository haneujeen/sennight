"""

    /motivations
    └── GET /

    -------------------------
    |      motivations      |
    -------------------------
    | id          | Integer |
    | category    | String  |
    | message     | String  |
    -------------------------

"""

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .. import database
from ..schemas import motivation_schemas
from ..crud import motivation_crud
from typing import List

router = APIRouter()


@router.get("/motivations")
async def read(db: Session = Depends(database.get_db)):
    motivations = motivation_crud.read(db)
    return {
        "status": True,
        "detail": "",
        "data": motivations
    }
