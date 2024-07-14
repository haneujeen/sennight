"""

    /user-activities
    ├── POST /
    ├── GET /{userID}
    └── DELETE /{userActivityID}

    -----------------------------
    |       user_activity       |
    -----------------------------
    | id              | Integer |
    | user_id         | Integer |
    | activity_id     | Integer |
    -----------------------------

"""
from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session
from .. import database
from ..schemas import activity_schemas
from ..crud import user_activity_crud
from typing import List

router = APIRouter()


@router.post("/user-activities")
async def create(
        user_activity: activity_schemas.UserActivityCreate,
        request: Request,
        db: Session = Depends(database.get_db)
):
    user_id = request.state.user_id
    new_user_activity = user_activity_crud.create(db, user_id, user_activity)

    return {
        "status": True,
        "detail": "User's activity added successfully",
        "data": new_user_activity
    }


@router.get("/user-activities/{user_id}")
async def read(user_id: int, db: Session = Depends(database.get_db)):
    user_activities = user_activity_crud.read(db, user_id)
    return {
        "status": True,
        "detail": "",
        "data": user_activities
    }


@router.delete("/user-activities/{user_activity_id}")
async def delete(user_activity_id: int, db: Session = Depends(database.get_db)):
    user_activity = user_activity_crud.delete(db, user_activity_id)
    return {
        "status": True,
        "detail": "User's activity deleted successfully",
        "data": {
            "user_id": user_activity.user_id,
            "activity_id": user_activity.activity_id
        }
    }
