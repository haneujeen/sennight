"""

    /user-motivations
    ├── POST /
    ├── GET /{userID}
    ├── PUT /{userMotivationID}
    └── DELETE /{userMotivationID}

    ---------------------------
    |     user_motivation     |
    ---------------------------
    | id            | Integer |
    | user_id       | Integer |
    | motivation_id | Integer |
    | message       | String  |
    ---------------------------

"""
from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session
from .. import database
from ..schemas import motivation_schemas
from ..crud import user_motivation_crud

router = APIRouter()


@router.post("/user-motivations")
async def create(
        user_motivation: motivation_schemas.UserMotivationCreate,
        request: Request,
        db: Session = Depends(database.get_db)
):
    user_id = request.state.user_id
    new_user_motivation = user_motivation_crud.create(db, user_id, user_motivation)

    return {
        "status": True,
        "detail": "User's motivation created successfully",
        "data": new_user_motivation
    }


@router.get("/user-motivations/{user_id}")
async def read(user_id: int, db: Session = Depends(database.get_db)):
    user_motivation = user_motivation_crud.read(db, user_id)
    return {
        "status": True,
        "detail": "",
        "data": user_motivation
    }


@router.put("/user-motivations/{user_motivation_id}")
async def update(
        user_motivation_id: int,
        user_motivation: motivation_schemas.UserMotivationUpdate,
        db: Session = Depends(database.get_db)
):
    updated_user_motivation = user_motivation_crud.update(db, user_motivation_id, user_motivation)

    return {
        "status": True,
        "detail": "User's motivation updated successfully",
        "data": updated_user_motivation
    }


@router.delete("/user-motivations/{user_motivation_id}")
async def delete(user_motivation_id: int, db: Session = Depends(database.get_db)):
    user_motivation = user_motivation_crud.delete(db, user_motivation_id)
    return {
        "status": True,
        "detail": "User's motivation deleted successfully",
        "data": {
            "user_id": user_motivation.user_id,
            "motivation_id": user_motivation.motivation_id
        }
    }
