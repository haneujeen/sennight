"""

    /user-symptoms
    ├── POST /
    ├── GET /{userID}
    └── DELETE /{userSymptomID}

    -----------------------------
    |       user_symptom        |
    -----------------------------
    | id              | Integer |
    | user_id         | Integer |
    | symptom_id      | Integer |
    -----------------------------

"""
from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session
from .. import database
from ..schemas import symptom_schemas
from ..crud import user_symptom_crud
from typing import List

router = APIRouter()


@router.post("/user-symptoms", response_model=symptom_schemas.UserSymptom)
async def create(
        user_symptom: symptom_schemas.UserSymptomCreate,
        request: Request,
        db: Session = Depends(database.get_db)
):
    user_id = request.state.user_id
    new_user_symptom = user_symptom_crud.create(db, user_id, user_symptom)

    return {
        "status": True,
        "detail": "User's symptom added successfully",
        "data": new_user_symptom
    }


@router.get("/user-symptoms/{user_id}", response_model=List[symptom_schemas.UserSymptom])
async def read(user_id: int, db: Session = Depends(database.get_db)):
    user_symptoms = user_symptom_crud.read(db, user_id)
    return {
        "status": True,
        "detail": "",
        "data": user_symptoms
    }


@router.delete("/user-symptoms/{user_symptom_id}")
async def delete(user_symptom_id: int, db: Session = Depends(database.get_db)):
    user_symptom = user_symptom_crud.delete(db, user_symptom_id)
    return {
        "status": True,
        "detail": "User's symptom deleted successfully",
        "data": {
            "user_id": user_symptom.user_id,
            "symptom_id": user_symptom.symptom_id
        }
    }
