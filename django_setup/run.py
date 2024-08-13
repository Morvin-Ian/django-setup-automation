import subprocess

def run_bash_script(script_path):
    try:
        result = subprocess.run(['bash', script_path], check=True, capture_output=True, text=True)
        
        # Output the results
        print("Script executed successfully!")
        print("Output:\n", result.stdout)    
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while executing the script: {e}")

if __name__ == "__main__":
    script_path = './install.sh' 
    run_bash_script(script_path)
