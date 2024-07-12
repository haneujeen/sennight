from pydantic import BaseModel
from typing import Optional


# Symptom schemas
class SymptomBase(BaseModel):
    title: str
    description: str


class SymptomCreate(SymptomBase):
    pass


class SymptomUpdate(SymptomBase):
    pass


class Symptom(SymptomBase):
    id: int

    class Config:
        from_attributes = True


# UserSymptom schemas
class UserSymptomBase(BaseModel):
    user_id: int
    symptom_id: int


class UserSymptomCreate(UserSymptomBase):
    pass


class UserSymptom(UserSymptomBase):
    id: int

    class Config:
        from_attributes = True
