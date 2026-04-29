"""
Piper TTS Server for Akash Network
Fast, MIT-licensed TTS with multi-voice support
"""

import os
import io
import base64
import logging
import asyncio
from typing import Optional
from pathlib import Path

from fastapi import FastAPI, HTTPException, Header
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import wave

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="Piper TTS API",
    description="High-performance Text-to-Speech API using Piper",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Global state
piper_process = None
SAMPLE_RATE = 22050
MODELS_DIR = Path("/app/models")
API_KEY = os.environ.get("API_KEY", "your-secret-api-key-change-this")


class SynthesizeRequest(BaseModel):
    """Request body for synthesis."""
    text: str = Field(..., max_length=5000, description="Text to synthesize")
    voice: str = Field(default="en_US-lessac-medium", description="Voice model ID")
    speed: float = Field(default=1.0, ge=0.5, le=2.0, description="Speech speed multiplier")


class SynthesizeResponse(BaseModel):
    """Response with audio data."""
    audio: str  # Base64 encoded WAV
    format: str = "wav"
    sample_rate: int = SAMPLE_RATE
    duration_seconds: float


class HealthResponse(BaseModel):
    """Health check response."""
    status: str
    available_voices: list[str]
    models_loaded: bool


class VoiceInfo(BaseModel):
    """Voice information."""
    id: str
    name: str
    language: str
    quality: str


# Available voices (you can download more from https://github.com/rhasspy/piper/releases)
AVAILABLE_VOICES = {
    "en_US-lessac-medium": {
        "name": "Lessac (American English)",
        "language": "en_US",
        "quality": "medium"
    },
    "en_US-amy-medium": {
        "name": "Amy (American English)",
        "language": "en_US",
        "quality": "medium"
    },
    "en_GB-alan-medium": {
        "name": "Alan (British English)",
        "language": "en_GB",
        "quality": "medium"
    },
    "es_ES-davefx-medium": {
        "name": "DaveFX (Spanish)",
        "language": "es_ES",
        "quality": "medium"
    },
    "fr_FR-siwis-medium": {
        "name": "Siwis (French)",
        "language": "fr_FR",
        "quality": "medium"
    },
    "de_DE-thorsten-medium": {
        "name": "Thorsten (German)",
        "language": "de_DE",
        "quality": "medium"
    },
}


def verify_api_key(authorization: str = Header(None)) -> bool:
    """Verify API key from header."""
    if not authorization:
        return False
    
    # Support both "Bearer TOKEN" and just "TOKEN"
    token = authorization.replace("Bearer ", "").strip()
    return token == API_KEY


def synthesize_with_piper_sync(text: str, voice: str, speed: float) -> bytes:
    """
    Synchronous Piper synthesis.
    Returns WAV file bytes.
    """
    import subprocess
    import wave
    
    model_path = MODELS_DIR / f"{voice}.onnx"
    
    if not model_path.exists():
        raise HTTPException(
            status_code=404,
            detail=f"Voice model '{voice}' not found. Available: {list(AVAILABLE_VOICES.keys())}"
        )
    
    try:
        # Run piper with input text using synchronous subprocess
        result = subprocess.run(
            [
                "piper",
                "--model", str(model_path),
                "--output_raw",
                "--length_scale", str(1.0 / speed),
            ],
            input=text.encode('utf-8'),
            capture_output=True,
            timeout=30  # 30 second timeout
        )
        
        if result.returncode != 0:
            error_msg = result.stderr.decode() if result.stderr else "Unknown error"
            logger.error(f"Piper error: {error_msg}")
            raise HTTPException(status_code=500, detail=f"TTS synthesis failed: {error_msg}")
        
        # Convert raw PCM to WAV
        wav_buffer = io.BytesIO()
        with wave.open(wav_buffer, 'wb') as wav_file:
            wav_file.setnchannels(1)  # Mono
            wav_file.setsampwidth(2)  # 16-bit
            wav_file.setframerate(SAMPLE_RATE)
            wav_file.writeframes(result.stdout)
        
        wav_buffer.seek(0)
        return wav_buffer.read()
        
    except subprocess.TimeoutExpired:
        logger.error("Piper process timeout")
        raise HTTPException(status_code=500, detail="TTS synthesis timeout")
    except FileNotFoundError:
        raise HTTPException(
            status_code=500,
            detail="Piper binary not found. Please check installation."
        )
    except Exception as e:
        logger.error(f"Synthesis error: {e}")
        raise HTTPException(status_code=500, detail=str(e))


async def synthesize_with_piper(text: str, voice: str, speed: float) -> bytes:
    """
    Async wrapper for Piper synthesis.
    """
    import asyncio
    # Run the synchronous function in a thread pool to avoid blocking
    return await asyncio.to_thread(synthesize_with_piper_sync, text, voice, speed)


@app.get("/health", response_model=HealthResponse)
async def health_check():
    """Check server health."""
    models_exist = MODELS_DIR.exists() and any(MODELS_DIR.glob("*.onnx"))
    
    return HealthResponse(
        status="healthy" if models_exist else "models_missing",
        available_voices=list(AVAILABLE_VOICES.keys()),
        models_loaded=models_exist
    )


@app.get("/voices", response_model=list[VoiceInfo])
async def list_voices():
    """List all available voices."""
    return [
        VoiceInfo(
            id=voice_id,
            name=info["name"],
            language=info["language"],
            quality=info["quality"]
        )
        for voice_id, info in AVAILABLE_VOICES.items()
    ]


@app.post("/synthesize", response_model=SynthesizeResponse)
async def synthesize(
    request: SynthesizeRequest,
    authorization: str = Header(None)
):
    """
    Synthesize speech from text.
    Requires API key in Authorization header.
    """
    # Verify API key
    if not verify_api_key(authorization):
        raise HTTPException(status_code=401, detail="Invalid or missing API key")
    
    logger.info(f"Synthesizing: '{request.text[:50]}...' with voice={request.voice}")
    
    # Generate audio
    wav_bytes = await synthesize_with_piper(request.text, request.voice, request.speed)
    
    # Calculate duration
    duration = len(wav_bytes) / (SAMPLE_RATE * 2)  # 2 bytes per sample (16-bit)
    
    # Encode to base64
    audio_base64 = base64.b64encode(wav_bytes).decode("utf-8")
    
    logger.info(f"Generated {len(wav_bytes)} bytes, duration: {duration:.2f}s")
    
    return SynthesizeResponse(
        audio=audio_base64,
        format="wav",
        sample_rate=SAMPLE_RATE,
        duration_seconds=round(duration, 2)
    )


@app.post("/synthesize/stream")
async def synthesize_stream(
    request: SynthesizeRequest,
    authorization: str = Header(None)
):
    """
    Streaming synthesis endpoint (future enhancement).
    Currently returns full audio.
    """
    return await synthesize(request, authorization)


if __name__ == "__main__":
    import uvicorn
    
    port = int(os.environ.get("PORT", "8080"))
    uvicorn.run(app, host="0.0.0.0", port=port)
