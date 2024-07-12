"""

    /symptoms
    └── GET /

    --------------------------
    |        symptom         |
    --------------------------
    | id           | Integer |
    | title        | String  |
    | description  | String  |
    --------------------------

"""

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .. import database
from ..schemas import symptom_schemas
from ..crud import symptom_crud
from typing import List

router = APIRouter()


@router.get("/symptoms", response_model=List[symptom_schemas.Symptom])
async def read(db: Session = Depends(database.get_db)):
    symptoms = symptom_crud.read(db)
    return {
        "status": True,
        "detail": "",
        "data": symptoms
    }
