from sqlalchemy.orm import Session
from .. import models


def read(db: Session):
    return db.query(models.Motivation).all()
