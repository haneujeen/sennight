from datetime import time
from typing import Optional
from pydantic import BaseModel


class SmokingHabitBase(BaseModel):
    user_id: int
    daily_cigarettes: Optional[int] = None
    cigarette_price: Optional[float] = None
    first_cigarette: Optional[time] = None
    smoking_years: Optional[int] = None


class SmokingHabitCreate(SmokingHabitBase):
    pass


class SmokingHabitUpdate(SmokingHabitBase):
    pass


class SmokingHabit(SmokingHabitBase):
    id: int

    class Config:
        from_attributes = True
