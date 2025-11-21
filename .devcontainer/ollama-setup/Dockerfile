FROM ollama/ollama:latest

RUN ollama serve & \
    sleep 5 && \
    ollama pull llama3.1:8b && \
    pkill ollama

EXPOSE 11434
CMD ["serve"]