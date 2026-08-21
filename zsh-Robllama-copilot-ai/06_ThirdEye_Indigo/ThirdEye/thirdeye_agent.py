import os

def process(user_query=None):
    """
    The ThirdEye Node (Intuition / Local Context Alignment).
    Hardcoded absolute tracking ensures stability under exec() wrappers.
    Recursively pulls files across the chakra ecosystem to feed local code into Groq.
    """
    # Force direct absolute alignment to your project root
    project_root = r"C:\zsh-copilot"
    compiled_logic = []

    # 1. READ ESSAY FOUNDATION
    essay_path = os.path.join(project_root, "tag-essay.txt")
    if os.path.exists(essay_path):
        try:
            with open(essay_path, "r", encoding="utf-8") as f:
                essay_content = f.read().strip()
                if essay_content:
                    compiled_logic.append(f"=== FOUNDATIONAL ETHOS (tag-essay.txt) ===\n{essay_content}\n")
        except Exception as e:
            compiled_logic.append(f"\n[ThirdEye Error]: Could not read local essay data. {str(e)}\n")

    # 2. RECURSIVELY SCAN LOGIC FILES ACROSS CHAKRA DIRECTORIES
    try:
        for root, dirs, files in os.walk(project_root):
            # Guardrail: Prevent environment directories from choking memory space
            if any(x in root for x in ["venv", ".git", "dist", "build"]):
                continue
                
            for file in files:
                # Target active agent code parameters, skipping the master orchestrator file
                if file.endswith(".py") and file != "master_orchestrator.py":
                    file_path = os.path.join(root, file)
                    relative_path = os.path.relpath(file_path, project_root)
                    
                    try:
                        with open(file_path, "r", encoding="utf-8") as f:
                            code_content = f.read().strip()
                        if code_content:
                            compiled_logic.append(f"📁 FILE LOGIC ACTIVE: {relative_path}\n```python\n{code_content}\n```\n")
                    except:
                        pass
    except Exception as e:
        compiled_logic.append(f"\n[ThirdEye Error]: Logic extraction map compromised. {str(e)}\n")

    # 3. RETURN INTEGRATED PAYLOAD FOR THE GRID MATCH
    if compiled_logic:
        return "\n".join(compiled_logic)
    return "No local codebase metrics or asset documentation located."

