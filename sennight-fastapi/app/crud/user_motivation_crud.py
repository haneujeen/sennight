from sqlalchemy.orm import Session
from fastapi import HTTPException
from .. import models
from ..schemas import motivation_schemas


def create(db: Session, user_id: int, user_motivation: motivation_schemas.UserMotivationCreate):
    db_user_motivation = models.UserMotivation(**user_motivation.model_dump(), user_id=user_id)
    db.add(db_user_motivation)
    db.commit()
    db.refresh(db_user_motivation)
    return db_user_motivation


def read(db: Session, user_id: int):
    return db.query(models.UserMotivation).filter(models.UserMotivation.user_id == user_id).first()


def update(db: Session, user_motivation_id: int, user_motivation: motivation_schemas.UserMotivationUpdate):
    db_user_motivation = db.query(models.UserMotivation).filter(models.UserMotivation.id == user_motivation_id).first()
    if not db_user_motivation:
        raise HTTPException(status_code=404, detail="User's motivation not found")
    for key, value in user_motivation.model_dump(exclude_unset=True).items():
        setattr(db_user_motivation, key, value)
    db.commit()
    db.refresh(db_user_motivation)
    return db_user_motivation


def delete(db: Session, user_motivation_id: int):
    db_user_motivation = db.query(models.UserMotivation).filter(models.UserMotivation.id == user_motivation_id).first()
    if not db_user_motivation:
        raise HTTPException(status_code=404, detail="User's motivation not found")
    db.delete(db_user_motivation)
    db.commit()
    return db_user_motivation
