from pydantic import BaseModel
from datetime import date
from typing import Optional


class QuitAttemptBase(BaseModel):
    start_date: date
    end_date: Optional[date] = None
    is_active: bool = True


class QuitAttemptCreate(QuitAttemptBase):
    pass


class QuitAttemptUpdate(QuitAttemptBase):
    pass


class QuitAttempt(QuitAttemptBase):
    id: int
    user_id: int

    class Config:
        from_attributes = True
