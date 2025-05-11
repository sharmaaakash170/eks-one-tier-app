from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def hello():
    return {"Hi, I am Aakash, this app is working"}


@app.get("/health")
def health_check():
    return {"status": "ok"}

