
"""

    /quit-attempts
    ├── POST /
    ├── GET /{userID}
    ├── GET /all/{userID}
    ├── PUT /{attemptID}
    ├── DELETE /{attemptID}
    └── GET /{attemptID}/milestones

    -------------------------
    |      quit_attempt     |
    -------------------------
    | id         | Integer  |
    | user_id    | Integer  |
    | start_date | Date     |
    | end_date   | Date     |
    | is_active  | Boolean  |
    -------------------------

"""

from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session
from .. import database, security
from ..schemas import quit_attempt_schemas, milestone_schemas
from ..crud import quit_attempt_crud
from typing import List

router = APIRouter()


@router.post("/quit-attempts")
async def create(
        quit_attempt: quit_attempt_schemas.QuitAttemptCreate,
        request: Request,
        db: Session = Depends(database.get_db)
):
    user_id = request.state.user_id
    new_quit_attempt = quit_attempt_crud.create(db, user_id, quit_attempt)

    return {
        "status": True,
        "detail": "Quit attempt created successfully",
        "data": {
            "user_id": new_quit_attempt.user_id
        }
    }


@router.get("/quit-attempts/{user_id}")
async def read(user_id: int, db: Session = Depends(database.get_db)):
    quit_attempt = quit_attempt_crud.read(db, user_id)
    return {
        "status": True,
        "detail": "",
        "data": {
            "id": quit_attempt.id,
            "user_id": quit_attempt.user_id,
            "start_date": quit_attempt.start_date,
            "is_active": quit_attempt.is_active
        }
    }


@router.get("/quit-attempts/all/{user_id}", response_model=List[quit_attempt_schemas.QuitAttempt])
async def read_all(user_id: int, db: Session = Depends(database.get_db)):
    quit_attempts = quit_attempt_crud.read_all(db, user_id)
    return {
        "status": True,
        "detail": "",
        "data": {
            "quit_attempts": quit_attempts
        }
    }


@router.put("/quit-attempts/{attempt_id}")
async def update(
        attempt_id: int,
        quit_attempt: quit_attempt_schemas.QuitAttemptUpdate,
        db: Session = Depends(database.get_db)
):
    updated_quit_attempt = quit_attempt_crud.update(db, attempt_id, quit_attempt)

    return {
        "status": True,
        "detail": "Quit attempt updated successfully",
        "data": {
            "user_id": updated_quit_attempt.user_id,
            "start_date": updated_quit_attempt.start_date,
            "end_date": updated_quit_attempt.end_date,
            "is_active": updated_quit_attempt.is_active
        }
    }


@router.delete("/quit-attempts/{attempt_id}")
async def delete(attempt_id: int, db: Session = Depends(database.get_db)):
    quit_attempt = quit_attempt_crud.delete(db, attempt_id)
    return {
        "status": True,
        "detail": "User deleted successfully",
        "data": {
            "user_id": quit_attempt.user_id
        }
    }


@router.post("/quit-attempts/{attempt_id}/milestones", response_model=List[milestone_schemas.UserMilestone])
async def read_milestones(attempt_id: int, db: Session = Depends(database.get_db)):
    milestones = quit_attempt_crud.read_milestones(db, attempt_id)
    return {
        "status": True,
        "detail": "Login successful",
        "data": {
            "milestones": milestones
        }
    }