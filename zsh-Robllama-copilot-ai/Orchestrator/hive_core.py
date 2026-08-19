import asyncio
import subprocess
from dataclasses import dataclass
from autogen_core import AgentId, SingleThreadedAgentRuntime, BaseAgent, MessageContext
from autogen_core.models import UserMessage
from autogen_ext.models.ollama import OllamaChatCompletionClient

@dataclass
class TelemetrySignal:
    content: str

@dataclass
class CodePatchSignal:
    patch_code: str

class SolarPlexusDiagnosticAgent(BaseAgent):
    def __init__(self, model_client: OllamaChatCompletionClient):
        super().__init__("SolarPlexus_Diagnostics")
        self._model = model_client

    async def on_message_impl(self, message: TelemetrySignal, ctx: MessageContext) -> None:
        print("\n[ASIC_BUS -> SolarPlexus] Syncing 0.052 coherence variables within zsh-copilot...", flush=True)
        prompt = f"Scan this coherence matrix for phase delay:\n{message.content}"
        
        response = await self._model.create(messages=[UserMessage(content=prompt, source="SolarPlexus")])
        print(f"[ASIC_LOG -> SolarPlexus Analysis Result]: Evaluation dispatched.", flush=True)
        
        await self.send_message(CodePatchSignal(patch_code=str(response.content)), recipient=AgentId("Throat_Coder", "default"))

class ThroatCoderAgent(BaseAgent):
    def __init__(self, model_client: OllamaChatCompletionClient):
        super().__init__("Throat_Coder")
        self._model = model_client

    async def on_message_impl(self, message: CodePatchSignal, ctx: MessageContext) -> None:
        print("\n[ASIC_BUS -> Throat] Generating Oracle VirtualBox environment patch...", flush=True)
        prompt = f"Convert these diagnostic results into a native execution patch:\n{message.patch_code}"
        
        response = await self._model.create(messages=[UserMessage(content=prompt, source="Throat")])
        print(f"[ASIC_LOG -> Throat Core Output]: Accessing VBoxManage controller...", flush=True)
        
        # Trigger the localized VirtualBox execution logic
        self.verify_vbox_state()

    def verify_vbox_state(self):
        """Interacts directly with VirtualBox CLI via native sub-process tracking"""
        try:
            # Query the machine metrics to confirm active state
            cmd = ["VBoxManage", "showvminfo", "RD-ORBIS", "--machinereadable"]
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=10)
            
            if "VMState=\"running\"" in result.stdout:
                print("[VBOX LOG]: RD-ORBIS container is online and tracking in-phase.", flush=True)
            else:
                print("[VBOX LOG]: RD-ORBIS container is offline. Executing headless boot sequencing...", flush=True)
                # Initialize the VM headless in the background to prevent terminal desktop focus loss
                subprocess.run(["VBoxManage", "startvm", "RD-ORBIS", "--type", "headless"], capture_output=True)
        except Exception as e:
            print(f"[VBOX WARNING]: Configuration link stalled. Verify instance name or PATH string. Error: {e}", flush=True)

async def boot_asic_fabric():
    runtime = SingleThreadedAgentRuntime()
    local_hardware_client = OllamaChatCompletionClient(
        host="http://localhost:11434",
        model="qwen2.5-coder:7b"
    )
    
    await SolarPlexusDiagnosticAgent.register(runtime, "SolarPlexus_Diagnostics", lambda: SolarPlexusDiagnosticAgent(local_hardware_client))
    await ThroatCoderAgent.register(runtime, "Throat_Coder", lambda: ThroatCoderAgent(local_hardware_client))
    
    runtime.start()

    # Read from your balanced local filesystem logs
    with open("C:/zsh-copilot/SolarPlexus/Logs/task_manager_coherence.csv", "r") as f:
        csv_data = f.read()

    print("[SYSTEM] ASIC Foundation Layer Initiated. Injecting telemetry onto bus...", flush=True)
    await runtime.send_message(TelemetrySignal(content=csv_data), recipient=AgentId("SolarPlexus_Diagnostics", "default"))
    await runtime.stop_when_idle()

if __name__ == "__main__":
    asyncio.run(boot_asic_fabric())
