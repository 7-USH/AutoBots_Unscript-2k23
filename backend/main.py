import uvicorn
from fastapi import FastAPI
from app.api.api import api_router

from starlette.middleware.cors import CORSMiddleware


app = FastAPI(
    title="FRCE Hack"
)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    return {"message": "Hello World"}

app.include_router(api_router, prefix="/api/v1")

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8080, reload=True)


# sched = BackgroundScheduler({'apscheduler.timezone': 'Asia/Kolkata'})
# sched.add_job(check_abscences, CronTrigger.from_crontab("15 1 * * *"))

# sched.start()
