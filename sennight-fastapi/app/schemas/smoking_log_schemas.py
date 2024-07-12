from datetime import date
from typing import Optional
from pydantic import BaseModel


class SmokingLogBase(BaseModel):
    cigarettes_smoked: int
    log_date: Optional[date] = None
    craving_level: Optional[int] = None
    trigger_id: Optional[int] = None


class SmokingLogCreate(SmokingLogBase):
    pass


class SmokingLogUpdate(SmokingLogBase):
    pass


class SmokingLog(SmokingLogBase):
    id: int
    user_id: int

    class Config:
        from_attributes = True
