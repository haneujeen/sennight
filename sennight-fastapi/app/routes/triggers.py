"""

    /triggers
    └── GET /

    -------------------------
    |       triggers        |
    -------------------------
    | id          | Integer |
    | name        | String  |
    | desc        | String  |
    -------------------------

"""

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .. import database
from ..schemas import trigger_schemas
from ..crud import trigger_crud
from typing import List

router = APIRouter()


@router.get("/triggers", response_model=List[trigger_schemas.Trigger])
async def read(db: Session = Depends(database.get_db)):
    triggers = trigger_crud.read(db)
    return {
        "status": True,
        "detail": "",
        "data": triggers
    }
