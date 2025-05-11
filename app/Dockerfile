FROM python:3.11-slim AS build 

WORKDIR /app 

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONOTWRITEBYTECODE=1

COPY requirements.txt .

RUN pip install --user --no-cache-dir -r requirements.txt 

FROM python:3.11-slim 

WORKDIR /app 

RUN useradd -m appuser && chown -R appuser /app 

USER appuser 

COPY --from=build /root/.local /home/appuser/.local 

COPY --chown=appuser:appuser . . 

ENV PATH=/home/appuser/.local/bin:$PATH PYTHONUNBUFFERED=1

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
            CMD curl -f http://localhost/health || exit 1

CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80" , "--workers", "4", "--timeout-keep-alive", "60"]