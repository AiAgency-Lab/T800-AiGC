import os
import sys
from groq import Groq

api_key = os.environ.get("GROQ_API_KEY")
if not api_key:
    print("☯️ [YIN] Error: GROQ_API_KEY environment variable not set on this machine.")
    sys.exit(1)

client = Groq(api_key=api_key)

def balance_terminal_input(user_prompt):
    system_instruction = """
    You are the Throat (Voice) module of zsh-copilot, operating on the principle of Yin and Yang.
    Every terminal command or question must be processed through two opposing, balanced halves:

    YANG (Active, Direct, Execution): 
    - Provide the exact PowerShell or command line instruction to achieve the goal.
    - No conversational filler or introductions. Just the raw, actionable syntax.

    YIN (Passive, Contextual, Guardrail):
    - Provide a calm, brief evaluation of what the command does.
    - Warn of any risks, folder modifications, or destructive traits.

    Output format MUST match this exact visual template:
    ☯️ [YANG - EXECUTION]
    command_here

    ☯️ [YIN - REFLECTION]
    Brief, high-value risk profile or logical explanation.
    """

    try:
        completion = client.chat.completions.create(
            model="llama-3.1-8b-instant",
            messages=[
                {"role": "system", "content": system_instruction},
                {"role": "user", "content": user_prompt}
            ],
            temperature=0.2
        )
        # Correctly parsing the choices index list object
        return completion.choices[0].message.content
    except Exception as e:
        return f"☯️ [YIN] API Error: Failed to communicate with Groq cloud engine. Details: {str(e)}"
