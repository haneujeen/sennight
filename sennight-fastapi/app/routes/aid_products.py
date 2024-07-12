"""

    /aid-products
    └── GET /

    -------------------------
    |      aid_product      |
    -------------------------
    | id          | Integer |
    | category    | String  |
    | name        | String  |
    -------------------------

"""

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from .. import database
from ..schemas import aid_product_schemas
from ..crud import aid_product_crud
from typing import List

router = APIRouter()


@router.get("/aid-products", response_model=List[aid_product_schemas.AidProduct])
async def read(db: Session = Depends(database.get_db)):
    aid_products = aid_product_crud.read(db)
    return {
        "status": True,
        "detail": "",
        "data": aid_products
    }
