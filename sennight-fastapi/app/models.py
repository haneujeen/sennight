from sqlalchemy import Column, Integer, String, Date, Float, DateTime, func, ForeignKey, Boolean, UniqueConstraint
from sqlalchemy.orm import relationship
from datetime import datetime, timezone
from .database import Base


class User(Base):
    __tablename__ = "user"
    id = Column(Integer, primary_key=True, autoincrement=True)
    email = Column(String(100), unique=True, index=True)
    name = Column(String(50))
    hashed_password = Column(String(255))

    created_at = Column(DateTime, server_default=func.now())
    updated_at = Column(DateTime, server_default=func.now(), onupdate=func.now())
    deleted_at = Column(DateTime, nullable=True)

    # Relationships
    quit_logs = relationship("QuitLog", back_populates="user", cascade="all, delete-orphan")
    smoking_logs = relationship("SmokingLog", back_populates="user", cascade="all, delete-orphan")
    motivation = relationship("UserMotivation", back_populates="user", cascade="all, delete-orphan")
    milestones = relationship("UserMilestone", back_populates="user", cascade="all, delete-orphan")
    milestone_posts = relationship("MilestonePost", back_populates="user", cascade="all, delete-orphan")
    aid_products = relationship("UserAidProduct", back_populates="user", cascade="all, delete-orphan")
    symptoms = relationship("UserSymptom", back_populates="user", cascade="all, delete-orphan")
    activities = relationship("UserActivity", back_populates="user", cascade="all, delete-orphan")

    def soft_delete(self):
        self.deleted_at = func.now()


class QuitLog(Base):
    __tablename__ = "quit_log"
    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))
    start_date = Column(Date, nullable=True)
    end_date = Column(Date, nullable=True)
    daily_cigarettes = Column(Integer, nullable=True)
    cigarette_price = Column(Float, nullable=True)
    is_active = Column(Boolean, default=True)

    user = relationship("User", back_populates="quit_logs")


class SmokingLog(Base):
    __tablename__ = "smoking_log"
    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))
    cigarettes_smoked = Column(Integer, nullable=False)
    date = Column(Date, default=lambda: datetime.now(timezone.utc).date())

    user = relationship("User", back_populates="smoking_logs")


class Motivation(Base):
    __tablename__ = "motivation"
    id = Column(Integer, primary_key=True, autoincrement=True)
    category = Column(String(50))
    message = Column(String(255))

    user_motivations = relationship("UserMotivation", back_populates="motivation", cascade="all, delete-orphan")


class UserMotivation(Base):
    __tablename__ = "user_motivation"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"), unique=True)
    motivation_id = Column(Integer, ForeignKey("motivation.id", ondelete="CASCADE"))
    message = Column(String(255))

    motivation = relationship("Motivation", back_populates="user_motivations")
    user = relationship("User", back_populates="motivation")

    __table_args__ = (UniqueConstraint('user_id', 'motivation_id', name='_user_motivation_uc'),)


class Milestone(Base):
    __tablename__ = "milestone"

    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(50))
    content = Column(String(255))

    user_milestones = relationship("UserMilestones", back_populates="milestone")


class UserMilestone(Base):
    __tablename__ = "user_milestone"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))
    milestone_id = Column(Integer, ForeignKey("milestone.id", ondelete="CASCADE"))
    date_achieved = Column(DateTime, server_default=func.now())

    milestone = relationship("Milestone", back_populates="user_milestones")
    user = relationship("User", back_populates="milestones")
    milestone_post = relationship("MilestonePost", back_populates="user_milestone")


class MilestonePost(Base):
    __tablename__ = "milestone_post"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))
    user_milestone_id = Column(Integer, ForeignKey("user_milestone.id", ondelete="CASCADE"), unique=True)
    support_count = Column(Integer)

    user = relationship("User", back_populates="milestone_posts")
    user_milestone = relationship("UserMilestone", back_populates="milestone_post")


class AidProduct(Base):
    __tablename__ = "aid_product"

    id = Column(Integer, primary_key=True, autoincrement=True)
    category = Column(String(50))
    name = Column(String(50))

    user_aid_products = relationship("UserFactor", back_populates="factor")


class UserAidProduct(Base):
    __tablename__ = "user_aid_product"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))
    aid_product_id = Column(Integer, ForeignKey("aid_product.id", ondelete="CASCADE"))
    start_date = Column(Date)
    end_date = Column(Date, nullable=True)

    factor = relationship("AidProduct", back_populates="user_aid_products")
    user = relationship("User", back_populates="aid_products")

    __table_args__ = (UniqueConstraint('user_id', 'aid_product_id', name='_user_aid_product_uc'),)


class Symptom(Base):
    __tablename__ = "symptom"

    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(50))
    description = Column(String(255))

    user_symptoms = relationship("User", back_populates="symptom")


class UserSymptom(Base):
    __tablename__ = "user_symptom"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))
    symptom_id = Column(Integer, ForeignKey("symptom.id", ondelete="CASCADE"))

    symptom = relationship("Symptom", back_populates="user_symptoms")
    user = relationship("User", back_populates="symptoms")

    __table_args__ = (UniqueConstraint('user_id', 'symptom_id', name='_user_symptom_uc'),)


class Activity(Base):
    __tablename__ = "activity"

    id = Column(Integer, primary_key=True, autoincrement=True)
    category = Column(String(50))
    name = Column(String(255))

    user_activities = relationship("UserActivity", back_populates="activity")


class UserActivity(Base):
    __tablename__ = "user_activity"

    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))
    activity_id = Column(Integer, ForeignKey("activity.id", ondelete="CASCADE"))

    activity = relationship("Activity", back_populates="user_activities")
    user = relationship("User", back_populates="activities")

    __table_args__ = (UniqueConstraint('user_id', 'activity_id', name='_user_activity_uc'),)
