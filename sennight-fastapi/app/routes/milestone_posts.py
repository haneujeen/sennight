"""

    /milestone-posts
        ├── POST /
        ├── GET /
        └── PUT /{milestonePostID}

    -------------------------------
    |       milestone_post        |
    -------------------------------
    | id                | Integer |
    | user_id           | Integer |
    | user_milestone_id | Integer |
    | quit_attempt_id   | Integer |
    | content           | String  |
    | support_count     | Integer |
    -------------------------------

"""
from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session
from .. import database
from ..schemas import milestone_post_schemas
from ..crud import milestone_post_crud
from typing import List

router = APIRouter()


@router.post("/milestone-posts")
async def create(
        milestone_post: milestone_post_schemas.MilestonePostCreate,
        request: Request,
        db: Session = Depends(database.get_db)
):
    user_id = request.state.user_id
    new_milestone_post = milestone_post_crud.create(db, user_id, milestone_post)

    return {
        "status": True,
        "detail": "Milestone post created successfully",
        "data": new_milestone_post
    }


# TODO: Add pagination
@router.get("/milestone-posts")
async def read(skip: int, limit: int, db: Session = Depends(database.get_db)):
    milestone_posts = milestone_post_crud.read(db)
    return {
        "status": True,
        "detail": "",
        "data": milestone_posts
    }


# Updates support count
@router.patch("/milestone-posts/{milestone_post_id}")
async def update(milestone_post_id: int, db: Session = Depends(database.get_db)):
    updated_milestone_post = milestone_post_crud.update(db, milestone_post_id)

    return {
        "status": True,
        "detail": "Support count updated successfully",
        "data": updated_milestone_post
    }
