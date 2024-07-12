from pydantic import BaseModel
from datetime import date
from typing import Optional


# AidProduct schemas
class AidProductBase(BaseModel):
    category: str
    name: str


class AidProductCreate(AidProductBase):
    pass


class AidProductUpdate(AidProductBase):
    pass


class AidProduct(AidProductBase):
    id: int

    class Config:
        from_attributes = True


# UserAidProduct schemas
class UserAidProductBase(BaseModel):
    user_id: int
    aid_product_id: int
    start_date: date
    end_date: Optional[date] = None


class UserAidProductCreate(UserAidProductBase):
    pass


class UserAidProductUpdate(UserAidProductBase):
    pass


class UserAidProduct(UserAidProductBase):
    id: int

    class Config:
        from_attributes = True
