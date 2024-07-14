"""

    /smoking-logs
    ├── POST /
    ├── GET /{userID}
    ├── PUT /{smokingLogID}
    └── DELETE /{smokingLogID}

    -------------------------------
    |         smoking_log         |
    -------------------------------
    | id                | Integer |
    | user_id           | Integer |
    | cigarettes_smoked | Integer |
    | log_date          | Date    |
    | craving_level     | Integer |
    | trigger_id        | Integer |
    -------------------------------

"""

from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session
from .. import database
from ..schemas import smoking_log_schemas
from ..crud import smoking_log_crud
from typing import List

router = APIRouter()


@router.post("/smoking-logs")
async def create(
        smoking_log: smoking_log_schemas.SmokingLogCreate,
        request: Request,
        db: Session = Depends(database.get_db)
):
    user_id = request.state.user_id
    new_smoking_log = smoking_log_crud.create(db, user_id, smoking_log)

    return {
        "status": True,
        "detail": "Smoking log created successfully",
        "data": new_smoking_log
    }


# TODO: Update smoking_log_crud.read()
# def read(db: Session, user_id: int, skip: int = 0, limit: int = 100):
#    return db.query(models.SmokingLog).filter(models.SmokingLog.user_id == user_id)
#       .offset(skip)
#       .limit(limit)
#       .all()
@router.get("/smoking-logs/{user_id}")
async def read(user_id: int, db: Session = Depends(database.get_db)):
    smoking_logs = smoking_log_crud.read(db, user_id)
    return {
        "status": True,
        "detail": "",
        "data": smoking_logs
    }


@router.put("/smoking-logs/{smoking_log_id}")
async def update(
        smoking_log_id: int,
        smoking_log: smoking_log_schemas.SmokingLogUpdate,
        db: Session = Depends(database.get_db)
):
    updated_quit_attempt = smoking_log_crud.update(db, smoking_log_id, smoking_log)

    return {
        "status": True,
        "detail": "Smoking log updated successfully",
        "data": updated_quit_attempt
    }


@router.delete("/smoking-logs/{smoking_log_id}")
async def delete(smoking_log_id: int, db: Session = Depends(database.get_db)):
    smoking_log = smoking_log_crud.delete(db, smoking_log_id)
    return {
        "status": True,
        "detail": "Smoking log deleted successfully",
        "data": {
            "user_id": smoking_log.user_id
        }
    }
