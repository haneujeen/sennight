from sqlalchemy.orm import Session
from fastapi import HTTPException
from .. import models
from ..schemas import symptom_schemas


def create(db: Session, user_id: int, user_symptom: symptom_schemas.UserSymptomCreate):
    db_user_symptom = models.UserSymptom(**user_symptom.model_dump(), user_id=user_id)
    db.add(db_user_symptom)
    db.commit()
    db.refresh(db_user_symptom)
    return db_user_symptom


def read(db: Session, user_id: int):
    return db.query(models.UserSymptom).filter(models.UserSymptom.user_id == user_id).all()


# TODO: Add Type Hinting...
# `def delete(db: Session, user_symptom_id: int) -> models.UserSymptom: ...`
def delete(db: Session, user_symptom_id: int):
    db_user_symptom = db.query(models.UserSymptom).filter(models.UserSymptom.id == user_symptom_id).first()
    if not db_user_symptom:
        raise HTTPException(status_code=404, detail="User's symptom not found")
    db.delete(db_user_symptom)
    db.commit()
    return db_user_symptom
