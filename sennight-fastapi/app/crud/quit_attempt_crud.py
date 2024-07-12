from fastapi import HTTPException
from sqlalchemy.orm import Session
from ..schemas import quit_attempt_schemas
from .. import models


def create(db: Session, user_id: int, quit_attempt: quit_attempt_schemas.QuitAttemptCreate):
    db_quit_attempt = models.QuitAttempt(**quit_attempt.model_dump(), user_id=user_id)
    db.add(db_quit_attempt)
    db.commit()
    db.refresh(db_quit_attempt)
    return db_quit_attempt


# Retrieves most recent quit attempt
def read(db: Session, user_id: int):
    return db.query(models.QuitAttempt).filter(
        models.QuitAttempt.user_id == user_id,
        models.QuitAttempt.is_active == True
    ).first()


# Retrieves all quit attempts
def read_all(db: Session, user_id: int):
    return db.query(models.QuitAttempt).filter(models.QuitAttempt.user_id == user_id).all()


def update(db: Session, attempt_id: int, quit_attempt: quit_attempt_schemas.QuitAttemptUpdate):
    db_quit_attempt = db.query(models.QuitAttempt).filter(models.QuitAttempt.id == attempt_id).first()
    if not db_quit_attempt:
        raise HTTPException(status_code=404, detail="Quit attempt not found")

    for key, value in quit_attempt.model_dump().items():
        setattr(db_quit_attempt, key, value)
    db.commit()
    db.refresh(db_quit_attempt)
    return db_quit_attempt


def delete(db: Session, attempt_id: int):
    db_quit_attempt = db.query(models.QuitAttempt).filter(models.QuitAttempt.id == attempt_id).first()
    if not db_quit_attempt:
        raise HTTPException(status_code=404, detail="Quit attempt not found")

    db.delete(db_quit_attempt)
    db.commit()
    return db_quit_attempt


def read_milestones(db: Session, attempt_id: int):
    return db.query(models.Milestone).filter(models.UserMilestone.quit_attempt_id == attempt_id).all()
