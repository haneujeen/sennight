from pydantic import BaseModel


# Activity schemas
class ActivityBase(BaseModel):
    category: str
    name: str


class ActivityCreate(ActivityBase):
    pass


class ActivityUpdate(ActivityBase):
    pass


class Activity(ActivityBase):
    id: int

    class Config:
        from_attributes = True


# UserActivity schemas
class UserActivityBase(BaseModel):
    user_id: int
    activity_id: int


class UserActivityCreate(UserActivityBase):
    pass


class UserActivityUpdate(BaseModel):
    pass


class UserActivity(UserActivityBase):
    id: int

    class Config:
        from_attributes = True
