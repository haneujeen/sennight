"""

    /activities
    └── GET /

    --------------------------
    |        activity        |
    --------------------------
    | id           | Integer |
    | title        | String  |
    | description  | String  |
    --------------------------

"""

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .. import database
from ..schemas import activity_schemas
from ..crud import activity_crud
from typing import List

router = APIRouter()


@router.get("/activities")
async def read(db: Session = Depends(database.get_db)):
    activities = activity_crud.read(db)
    return {
        "status": True,
        "detail": "",
        "data": activities
    }
