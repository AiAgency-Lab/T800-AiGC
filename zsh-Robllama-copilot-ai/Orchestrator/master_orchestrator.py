import sys
import os

CHAKRAS = ["Root", "Sacral", "SolarPlexus", "Heart", "Throat", "ThirdEye", "Crown"]

def main():
    if len(sys.argv) < 2:
        print("☯️ [YIN] Error: Empty intent received.")
        sys.exit(1)

    user_query = " ".join(sys.argv[1:])
    orchestrator_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(orchestrator_dir)

    print("\n" + "="*60)
    print("☯️  ALIGNING THE 7 CHAKRA SYSTEM NETWORKS")
    print("="*60)

    # 1. READ LOCAL CONTEXT FROM THIRDEYE
    local_intuition = ""
    thirdeye_script = os.path.join(project_root, "ThirdEye", "thirdeye_agent.py")
    if os.path.exists(thirdeye_script):
        try:
            thirdeye_globals = {}
            with open(thirdeye_script, "r", encoding="utf-8") as f:
                exec(f.read(), thirdeye_globals)
            if "process" in thirdeye_globals:
                local_intuition = thirdeye_globals["process"](user_query)
        except Exception as e:
            print(f"[!] ThirdEye Vision Blocked: {str(e)}")

    print("[+] System Realignment Complete. Routing context straight to Throat Node via Groq...\n")

    # 2. RUN SYNTHESIS THROUGH THROAT WITH LOCAL INSIGHTS
    throat_script = os.path.join(project_root, "Throat", "throat_agent.py")
    
    try:
        throat_globals = {}
        with open(throat_script, "r", encoding="utf-8") as f:
            exec(f.read(), throat_globals)
        
        target_func = None
        for name in ["balance_terminal_input", "balance_input", "main"]:
            if name in throat_globals:
                target_func = throat_globals[name]
                break
                
        if target_func:
            # Combine the user query with the essay insights for deep context alignment
            enriched_prompt = user_query
            if local_intuition:
                enriched_prompt += f"\n\nContextual Guidelines for this operator:\n{local_intuition}"
                
            print(target_func(enriched_prompt))
        else:
            print("☯️ [YIN] Alignment Error: Found Throat node, but 'balance_terminal_input' is missing.")
    except Exception as e:
        print(f"☯️ [YIN] Pipeline Breakdown: {str(e)}")

    print("="*60)

if __name__ == "__main__":
    main()
