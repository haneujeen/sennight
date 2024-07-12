from pydantic import BaseModel


class TriggerBase(BaseModel):
    name: str
    desc: str


class TriggerCreate(TriggerBase):
    pass


class TriggerUpdate(TriggerBase):
    pass


class Trigger(TriggerBase):
    id: int

    class Config:
        from_attributes = True
