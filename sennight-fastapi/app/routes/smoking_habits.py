"""

    /smoking-habits
    ├── POST /
    ├── GET /{userID}
    └── PUT /{habitID}

    ------------------------------
    |       smoking_habit        |
    ------------------------------
    | id               | Integer |
    | user_id          | Integer |
    | daily_cigarettes | Integer |
    | cigarette_price  | Float   |
    | first_cigarette  | Time    |
    | smoking_years    | Integer |
    ------------------------------

"""

from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session
from .. import database
from ..schemas import smoking_habit_schemas
from ..crud import smoking_habit_crud

router = APIRouter()


@router.post("/smoking-habits")
def create(
        smoking_habit: smoking_habit_schemas.SmokingHabitCreate,
        request: Request,
        db: Session = Depends(database.get_db)
):
    user_id = request.state.user_id
    new_habit = smoking_habit_crud.create(db, user_id, smoking_habit)

    return {
        "status": True,
        "detail": "Smoking habit created successfully",
        "data": {
            "user_id": new_habit.user_id
        }
    }


@router.get("/smoking-habits/{user_id}")
async def read(user_id: int, db: Session = Depends(database.get_db)):
    smoking_habit = smoking_habit_crud.read(db, user_id)
    first_cigarette = smoking_habit.first_cigarette.strftime("%H:%M:%S") if smoking_habit.first_cigarette else None
    return {
        "status": True,
        "detail": "",
        "data": {
            "id": smoking_habit.id,
            "user_id": smoking_habit.user_id,
            "daily_cigarettes": smoking_habit.daily_cigarettes,
            "cigarette_price": smoking_habit.cigarette_price,
            "first_cigarette": first_cigarette,
            "smoking_years": smoking_habit.smoking_years
        }
    }


@router.put("/smoking-habits/{habit_id}")
async def update(
        habit_id: int,
        smoking_habit: smoking_habit_schemas.SmokingHabitUpdate,
        db: Session = Depends(database.get_db)
):
    updated_habit = smoking_habit_crud.update(db, habit_id, smoking_habit)
    first_cigarette = updated_habit.first_cigarette.strftime("%H:%M:%S") if updated_habit.first_cigarette else None

    return {
        "status": True,
        "detail": "Smoking habit updated successfully",
        "data": {
            "user_id": updated_habit.user_id,
            "daily_cigarettes": updated_habit.daily_cigarettes,
            "cigarette_price": updated_habit.cigarette_price,
            "first_cigarette": first_cigarette,
            "smoking_years": updated_habit.smoking_years
        }
    }
