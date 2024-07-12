from sqlalchemy.orm import Session
from fastapi import HTTPException
from .. import models
from ..schemas import activity_schemas


def create(db: Session, user_id: int, user_activity: activity_schemas.UserActivityCreate):
    db_user_activity = models.UserActivity(**user_activity.model_dump(), user_id=user_id)
    db.add(db_user_activity)
    db.commit()
    db.refresh(db_user_activity)
    return db_user_activity


def read(db: Session, user_id: int):
    return db.query(models.UserActivity).filter(models.UserActivity.user_id == user_id).all()


def delete(db: Session, user_activity_id: int):
    db_user_activity = db.query(models.UserActivity).filter(models.UserActivity.id == user_activity_id).first()
    if not db_user_activity:
        raise HTTPException(status_code=404, detail="User's activity not found")
    db.delete(db_user_activity)
    db.commit()
    return db_user_activity
