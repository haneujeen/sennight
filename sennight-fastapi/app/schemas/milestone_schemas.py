from pydantic import BaseModel
from datetime import datetime
from typing import Optional


# Milestone schemas
class MilestoneBase(BaseModel):
    title: str
    content: str


class MilestoneCreate(MilestoneBase):
    pass


class MilestoneUpdate(MilestoneBase):
    pass


class Milestone(MilestoneBase):
    id: int

    class Config:
        from_attributes = True


# UserMilestone schemas
class UserMilestoneBase(BaseModel):
    user_id: int
    milestone_id: int
    quit_attempt_id: int
    date_achieved: Optional[datetime] = None


class UserMilestoneCreate(UserMilestoneBase):
    pass


class UserMilestone(UserMilestoneBase):
    id: int
    milestone: Milestone

    class Config:
        from_attributes = True
