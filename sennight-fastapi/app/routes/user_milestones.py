"""

    /user-milestones
    ├── POST /
    └── GET /{userID}

    ------------------------------
    |       user_milestone       |
    ------------------------------
    | id              | Integer  |
    | user_id         | Integer  |
    | milestone_id    | Integer  |
    | quit_attempt_id | Integer  |
    | date_achieved   | DateTime |
    ------------------------------

"""
from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session
from .. import database
from ..schemas import milestone_schemas
from ..crud import user_milestone_crud
from typing import List

router = APIRouter()


@router.post("/user-milestones")
async def create(
        user_milestone: milestone_schemas.UserMilestoneCreate,
        request: Request,
        db: Session = Depends(database.get_db)
):
    user_id = request.state.user_id
    new_user_milestone = user_milestone_crud.create(db, user_id, user_milestone)

    return {
        "status": True,
        "detail": "User's milestone created successfully",
        "data": new_user_milestone
    }


@router.get("/user-milestones/{user_id}")
async def read(user_id: int, db: Session = Depends(database.get_db)):
    user_milestones = user_milestone_crud.read(db, user_id)
    return {
        "status": True,
        "detail": "",
        "data": user_milestones
    }
