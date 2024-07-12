"""

    /health-benefits
    └── GET /

    -----------------------------
    |      health_benefit       |
    -----------------------------
    | id              | Integer |
    | time_interval   | String  |
    | name            | String  |
    | desc            | String  |
    -----------------------------

"""

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .. import database
from ..schemas import health_benefit_schemas
from ..crud import health_benefit_crud
from typing import List

router = APIRouter()


@router.get("/health-benefits", response_model=List[health_benefit_schemas.HealthBenefit])
async def read(db: Session = Depends(database.get_db)):
    health_benefits = health_benefit_crud.read(db)
    return {
        "status": True,
        "detail": "",
        "data": health_benefits
    }
