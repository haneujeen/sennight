from pydantic import BaseModel
from typing import Optional


# Motivation schemas
class MotivationBase(BaseModel):
    category: str
    message: str


class MotivationCreate(MotivationBase):
    pass


class MotivationUpdate(MotivationBase):
    pass


class Motivation(MotivationBase):
    id: int

    class Config:
        from_attributes = True


# UserMotivation schemas
class UserMotivationBase(BaseModel):
    message: Optional[str] = None


class UserMotivationCreate(UserMotivationBase):
    user_id: int
    motivation_id: int


class UserMotivationUpdate(UserMotivationBase):
    user_id: Optional[int] = None
    motivation_id: Optional[int] = None


class UserMotivation(UserMotivationBase):
    id: int
    user_id: int
    motivation_id: int
    motivation: Motivation

    class Config:
        from_attributes = True
