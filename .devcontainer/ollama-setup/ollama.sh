#!/bin/sh
set -e

ollama serve

ollama pull llama3.1:8b
wait -n