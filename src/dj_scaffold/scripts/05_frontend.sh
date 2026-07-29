#!/bin/bash

html_content_to_append=$(cat << EOL
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Introduction to Django</title>
    <style>
        body {
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: #93D7B7;;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #fff; /* Django green */
            text-align: center;
            margin-bottom: 20px;
            padding: 20px;
            background-color: #0C4B33;
        }

        p {
            color: #333; /* Dark gray */
            line-height: 1.5;
        }

        .link {
            display: block;
            text-align: center;
            margin-top: 40px;
        }

        .link a {
            color: #007bff; /* Django blue */
            text-decoration: none;
            font-weight: bold;
        }

        .link a:hover {
            text-decoration: underline;
        }

        .acknowledgement {
            text-align: center;
            margin-top: 40px;
            font-size: 14px;
            color: #666; /* Medium gray */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Django Framework</h1>
        <p>Django is a high-level Python web framework that enables rapid development of secure and scalable web applications.
            If you want to learn more about Django, check out the <a href="https://docs.djangoproject.com/" target="_blank">Official Documetation</a>.</p>

        </p>
        <div class="link">
            <small>Have more ideas on making the automation setup more effecient?            
                 <a href="https://github.com/Morvin-Ian/django-setup-automation" target="_blank">Contribute on GitHub</a>
            </small>
        </div>
        <div class="acknowledgement">
            <p><strong>Acknowledgement</strong>:                
                <a href="https://twitter.com/@OluochIan" target="_blank">Morvin Ian</a>
            </p>
        </div>
    </div>
</body>
</html>

EOL
)


# Create frontend directory structure
mkdir -p "frontend/templates/$appName" "frontend/static"

echo "$html_content_to_append" > "frontend/templates/$appName/index.html"

GREEN='\033[0;32m'
BOLD='\033[1m'
RESET='\033[0m'

statement="Django Installation and setup successful - NOW RUN COMMAND 'python manage.py runserver' "


terminal_width=$(tput cols)

num_asterisks=$(( (terminal_width - ${#statement}) / 2 - 1))

printf "%${terminal_width}s\n" | tr ' ' '*'

printf "%${num_asterisks}s${GREEN}${BOLD}%s${RESET}%${num_asterisks}s\n" "" "$statement" ""

printf "%${terminal_width}s\n" | tr ' ' '*'

# ---------------------------------------------------------------------------
# Optional cleanup: remove installation files and rename folder to project name
# ---------------------------------------------------------------------------
echo ""
read -p "Remove installation files and rename folder to '${projectName}'? (y/N): " cleanup_answer

if [[ "$cleanup_answer" =~ ^[Yy]$ ]]; then
    echo "Cleaning up installation files..."

    parent_dir=$(dirname "$PWD")
    current_dir_name=$(basename "$PWD")

    # Remove installation scripts and documentation
    rm -f install.sh 01_intro.sh 02_django-installation.sh \
          03_project-setup.sh 04_settings.sh 05_frontend.sh
    rm -f README.md LICENSE.txt
    rm -rf docs/ .git/ .gitignore

    echo "Installation files removed."

    # Rename the folder to the project name (if different)
    if [ "$current_dir_name" != "$projectName" ]; then
        cd "$parent_dir"
        mv "$current_dir_name" "$projectName"
        cd "$projectName"
        echo "Folder renamed to '$projectName'."
        echo "Your project is now at: $parent_dir/$projectName"
    else
        echo "Folder already named '$projectName'."
    fi

    echo "Cleanup complete!"
fi
