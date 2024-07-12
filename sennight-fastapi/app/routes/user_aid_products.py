"""

    /user-aid-products
    ├── POST /
    ├── GET /{userID}
    └── DELETE /{userAidProductID}

    -----------------------------
    |     user_aid_product      |
    -----------------------------
    | id              | Integer |
    | user_id         | Integer |
    | aid_product_id  | Integer |
    | start_date      | Date    |
    | end_date        | Date    |
    -----------------------------

"""
from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session
from .. import database
from ..schemas import aid_product_schemas
from ..crud import user_aid_product_crud
from typing import List

router = APIRouter()


@router.post("/user-aid-products", response_model=aid_product_schemas.UserAidProduct)
async def create(
        user_aid_product: aid_product_schemas.UserAidProductCreate,
        request: Request,
        db: Session = Depends(database.get_db)
):
    user_id = request.state.user_id
    new_user_aid_product = user_aid_product_crud.create(db, user_id, user_aid_product)

    return {
        "status": True,
        "detail": "User's aid product added successfully",
        "data": new_user_aid_product
    }


@router.get("/user-aid-products/{user_id}", response_model=List[aid_product_schemas.UserAidProduct])
async def read(user_id: int, db: Session = Depends(database.get_db)):
    user_aid_products = user_aid_product_crud.read(db, user_id)
    return {
        "status": True,
        "detail": "",
        "data": user_aid_products
    }


@router.delete("/user-aid-products/{user_aid_product_id}")
async def delete(user_aid_product_id: int, db: Session = Depends(database.get_db)):
    user_aid_product = user_aid_product_crud.delete(db, user_aid_product_id)
    return {
        "status": True,
        "detail": "User's aid product deleted successfully",
        "data": {
            "user_id": user_aid_product.user_id,
            "aid_product_id": user_aid_product.aid_product_id
        }
    }
