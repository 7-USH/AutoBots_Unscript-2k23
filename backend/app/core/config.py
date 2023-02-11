import os


class Settings:
    SECRET_KEY = "qWMGso8lYDM5Hk2Dlmi-Kkth-clxTPZu_ctWjziiU4w"
    ACCESS_TOKEN_EXPIRE_MINUTES = int = 60 * 24 * 8

    SENDER_EMAIL = os.environ.get("SENDER_EMAIL", "soumitrakand3@gmail.com")
    EMAIL_PASSWORD = os.environ.get("EMAIL_PASSWORD", "ciekkwjqjmxuclcb")
    X_API_KEY = os.environ.get(
        "X_API_KEY", "lSVB74GZppMJ35d0r6Enp1e85X8s0bTxc2jqJYhf17WONaJn2ufSFMxRNi1Y")


settings = Settings()
