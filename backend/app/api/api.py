from fastapi import APIRouter

from .endpoints import (users, login, bond_scrape, bond_requests, user_bonds)

api_router = APIRouter()


api_router.include_router(users.router, prefix="/user", tags=["register-user"])
api_router.include_router(login.router, prefix="/login", tags=["login"])
api_router.include_router(
    bond_scrape.router, prefix="/live-data", tags=["live-data"])
api_router.include_router(
    user_bonds.router, prefix="/user-bonds", tags=["user-bonds"])
api_router.include_router(
    bond_requests.router, prefix="/bond-requests", tags=["bond-requests"])
