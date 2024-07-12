from datetime import datetime
from typing import List, Optional
from pydantic import BaseModel, EmailStr
from .smoking_habit_schemas import SmokingHabit
from .quit_attempt_schemas import QuitAttempt
from .smoking_log_schemas import SmokingLog
from .motivation_schemas import UserMotivation
from .milestone_schemas import UserMilestone
from .aid_product_schemas import UserAidProduct
from .symptom_schemas import UserSymptom
from .activity_schemas import UserActivity


class UserBase(BaseModel):
    email: EmailStr
    name: str


class UserCreate(UserBase):
    password: str
    photo_filename: Optional[str] = None


class UserUpdate(UserBase):
    name: Optional[str] = None
    password: Optional[str] = None
    photo_filename: Optional[str] = None


class UserLogin(UserBase):
    name: Optional[str] = None
    password: str


class User(UserBase):
    id: int
    photo_filename: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    deleted_at: Optional[datetime] = None
    smoking_habit: Optional[SmokingHabit] = None
    quit_attempts: List[QuitAttempt] = []
    smoking_logs: List[SmokingLog] = []
    motivation: Optional[UserMotivation] = None
    milestones: List[UserMilestone] = []
    aid_products: List[UserAidProduct] = []
    symptoms: List[UserSymptom] = []
    activities: List[UserActivity] = []

    class Config:
        from_attributes = True
