from pydantic import BaseModel


class HealthBenefitBase(BaseModel):
    time_interval: str
    name: str
    desc: str


class HealthBenefitCreate(HealthBenefitBase):
    pass


class HealthBenefitUpdate(HealthBenefitBase):
    pass


class HealthBenefit(HealthBenefitBase):
    id: int

    class Config:
        from_attributes = True
