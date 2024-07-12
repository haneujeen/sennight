from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import JSONResponse
from jose import jwt, JWTError
from .database import engine, Base
from .routes import users, smoking_habits, quit_attempts, smoking_logs, \
    health_benefits, triggers, motivations, milestones, aid_products, symptoms, activities, \
    user_motivations, user_milestones, user_aid_products, user_symptoms, user_activities, milestone_posts
from .config import settings

Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(users.router, prefix="/users")
app.include_router(smoking_habits.router)
app.include_router(quit_attempts.router)
app.include_router(smoking_logs.router)
app.include_router(health_benefits.router)
app.include_router(triggers.router)
app.include_router(motivations.router)
app.include_router(milestones.router)
app.include_router(aid_products.router)
app.include_router(symptoms.router)
app.include_router(activities.router)
app.include_router(user_motivations.router)
app.include_router(user_milestones.router)
app.include_router(user_aid_products.router)
app.include_router(user_symptoms.router)
app.include_router(user_activities.router)
app.include_router(milestone_posts.router)


@app.middleware("http")
async def jwt_middleware(request: Request, call_next):
    if request.url.path.startswith("/docs") or request.url.path.startswith("/openapi.json"):
        return await call_next(request)
    if request.method == "POST" and request.url.path.startswith("/users"):
        return await call_next(request)
    authorization: str = request.headers.get("Authorization")
    if authorization is None or not authorization.startswith("Bearer "):
        return JSONResponse(
            status_code=401,
            content={"status": False, "detail": "Unauthorized", "data": None}
        )

    token = authorization[7:]
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        user_id = payload.get("sub")
        if user_id is None:
            raise JWTError()
        request.state.user_id = user_id
    except JWTError as e:
        return JSONResponse(
            status_code=401,
            content={"status": False, "detail": "Invalid token", "data": None}
        )
    return await call_next(request)


@app.exception_handler(HTTPException)
async def custom_http_exception_handler(request: Request, exc: HTTPException):
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "status": False,
            "detail": exc.detail,
            "data": None
        }
    )

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
