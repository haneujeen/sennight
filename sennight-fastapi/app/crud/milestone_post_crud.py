from sqlalchemy.orm import Session
from fastapi import HTTPException
from .. import models
from ..schemas import milestone_post_schemas


def create(db: Session, user_id: int, milestone_post: milestone_post_schemas.MilestonePostCreate):
    db_milestone_post = models.MilestonePost(**milestone_post.model_dump(), user_id=user_id)
    db.add(db_milestone_post)
    db.commit()
    db.refresh(db_milestone_post)
    return db_milestone_post


def read(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.MilestonePost).order_by(models.MilestonePost.created_at.desc()).offset(skip).limit(limit).all()


# Updates support count
def update(db: Session, milestone_post_id: int):
    db_milestone_post = db.query(models.MilestonePost).filter(models.MilestonePost.id == milestone_post_id).first()
    if not db_milestone_post:
        raise HTTPException(status_code=404, detail="Milestone post not found")
    db_milestone_post.support_count += 1
    db.commit()
    db.refresh(db_milestone_post)
    return db_milestone_post
