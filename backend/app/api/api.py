from fastapi import APIRouter

from .endpoints import users, login, bond_scrape

api_router = APIRouter()


api_router.include_router(users.router, prefix="/user", tags=["register-user"])
api_router.include_router(login.router, prefix="/login", tags=["login"])
api_router.include_router(
    bond_scrape.router, prefix="/live-data", tags=["live-data"])
