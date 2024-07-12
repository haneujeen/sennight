from sqlalchemy.orm import Session
from fastapi import HTTPException
from .. import models
from ..schemas import aid_product_schemas


def create(db: Session, user_id: int, user_aid_product: aid_product_schemas.UserAidProductCreate):
    db_user_aid_product = models.UserAidProduct(**user_aid_product.model_dump(), user_id=user_id)
    db.add(db_user_aid_product)
    db.commit()
    db.refresh(db_user_aid_product)
    return db_user_aid_product


def read(db: Session, user_id: int):
    return db.query(models.UserAidProduct).filter(models.UserAidProduct.user_id == user_id).all()


def delete(db: Session, user_aid_product_id: int):
    db_user_aid_product = db.query(models.UserAidProduct).filter(models.UserAidProduct.id == user_aid_product_id).first()
    if not db_user_aid_product:
        raise HTTPException(status_code=404, detail="User's aid product not found")
    db.delete(db_user_aid_product)
    db.commit()
    return db_user_aid_product
