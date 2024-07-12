from fastapi import HTTPException
from sqlalchemy.orm import Session
from datetime import datetime, date
from .. import models, security
from ..schemas import smoking_habit_schemas


# TODO: Update functions with .model_dump()
def create(db: Session, user_id: int, smoking_habit: smoking_habit_schemas.SmokingHabitCreate):
    db_habit = db.query(models.SmokingHabit).filter(models.SmokingHabit.user_id == user_id).first()
    if db_habit:
        raise HTTPException(status_code=400, detail="Smoking habit already exists")

    db_habit = models.SmokingHabit(
        user_id=user_id,
        daily_cigarettes=smoking_habit.daily_cigarettes,
        cigarette_price=smoking_habit.cigarette_price,
        first_cigarette=smoking_habit.first_cigarette,
        smoking_years=smoking_habit.smoking_years
    )
    db.add(db_habit)
    db.commit()
    db.refresh(db_habit)
    return db_habit


def read(db: Session, user_id: int):
    db_habit = db.query(models.SmokingHabit).filter(models.SmokingHabit.user_id == user_id).first()
    if db_habit is None:
        raise HTTPException(status_code=404, detail="Smoking habit not found")
    return db_habit


def update(db: Session, habit_id: int, smoking_habit: smoking_habit_schemas.SmokingHabitUpdate):
    db_habit = db.query(models.SmokingHabit).filter(models.SmokingHabit.id == habit_id).first()
    if db_habit is None:
        raise HTTPException(status_code=404, detail="Smoking habit not found")

    if smoking_habit.daily_cigarettes:
        db_habit.daily_cigarettes = smoking_habit.daily_cigarettes
    if smoking_habit.cigarette_price:
        db_habit.cigarette_price = smoking_habit.cigarette_price
    if smoking_habit.first_cigarette:
        db_habit.first_cigarette = smoking_habit.first_cigarette
    if smoking_habit.smoking_years:
        db_habit.smoking_years = smoking_habit.smoking_years
    db.commit()
    db.refresh(db_habit)
    return db_habit
