from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


sql_connection_str = "postgresql+psycopg2://postgres:cq3BPQvGfcBnDxkvj056@containers-us-west-135.railway.app:7525/railway"


engine = create_engine(
    sql_connection_str, pool_pre_ping=True, future=True
)

SessionLocal = sessionmaker(
    autocommit=False, autoflush=False, bind=engine, future=True
)

db = SessionLocal()
