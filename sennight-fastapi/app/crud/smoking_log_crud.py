from sqlalchemy.orm import Session
from fastapi import HTTPException
from .. import models
from ..schemas import smoking_log_schemas


def create(db: Session, user_id: int, smoking_log: smoking_log_schemas.SmokingLogCreate):
    db_smoking_log = models.SmokingLog(**smoking_log.model_dump(), user_id=user_id)
    db.add(db_smoking_log)
    db.commit()
    db.refresh(db_smoking_log)
    return db_smoking_log


def read(db: Session, user_id: int, skip: int = 0, limit: int = 100):
    return db.query(models.SmokingLog).filter(models.SmokingLog.user_id == user_id).offset(skip).limit(limit).all()


def update(db: Session, smoking_log_id: int, smoking_log: smoking_log_schemas.SmokingLogUpdate):
    db_smoking_log = db.query(models.SmokingLog).filter(models.SmokingLog.id == smoking_log_id).first()
    if not db_smoking_log:
        raise HTTPException(status_code=404, detail="SmokingLog not found")
    for key, value in smoking_log.model_dump(exclude_unset=True).items():
        setattr(db_smoking_log, key, value)
    db.commit()
    db.refresh(db_smoking_log)
    return db_smoking_log


def delete(db: Session, smoking_log_id: int):
    db_smoking_log = db.query(models.SmokingLog).filter(models.SmokingLog.id == smoking_log_id).first()
    if not db_smoking_log:
        raise HTTPException(status_code=404, detail="SmokingLog not found")
    db.delete(db_smoking_log)
    db.commit()
    return db_smoking_log
