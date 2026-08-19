import asyncio
import sys
import argparse
from autogen_core.models import UserMessage
from autogen_ext.models.ollama import OllamaChatCompletionClient

async def run_stream(prompt: str, model_name: str, port: int):
    client = OllamaChatCompletionClient(
        host=f"http://localhost:{port}",
        model=model_name
    )
    
    print(f"\n[STREAMING FROM -> {model_name} on Port {port}]:\n", flush=True)
    
    try:
        async for chunk in client.create_stream(messages=[UserMessage(content=prompt, source="user")]):
            # Dynamic type handling: Check if it's an object with .content or a raw string
            text_fragment = ""
            if hasattr(chunk, 'content') and chunk.content is not None:
                text_fragment = chunk.content
            elif isinstance(chunk, str):
                text_fragment = chunk
                
            if text_fragment:
                sys.stdout.write(text_fragment)
                sys.stdout.flush()
    except Exception as e:
        print(f"\n[STREAM EXCEPTION HANDLED]: {e}", flush=True)
        
    print("\n\n[STREAM COMPLETE]")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Real-time Local LLM Token Streamer")
    parser.add_argument("prompt", type=str, help="The prompt or math data to pass to the engine")
    parser.add_argument("--model", type=str, default="qwen2.5-coder:7b", help="Model targeting specification")
    parser.add_argument("--port", type=int, default=11434, help="Target network port mapping")
    
    args = parser.parse_args()
    asyncio.run(run_stream(args.prompt, args.model, args.port))
