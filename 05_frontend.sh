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


mkdir frontend && cd frontend && mkdir templates && mkdir static

cd templates

mkdir $appName && cd $appName && touch index.html 


echo "$html_content_to_append" >> index.html 

cd ../../../

new_directory="bash scripts"

# List of files to copy
files=("01_intro.sh" "02_django-installation.sh" "03_project-setup.sh" "04_settings.sh" "05_frontend.sh" "install.sh")

# Create the new directory
mkdir "$new_directory"

# Copy the files to the new directory
for file in "${files[@]}"; do
    mv "$file" "$new_directory"
done



GREEN='\033[0;32m'
BOLD='\033[1m'
RESET='\033[0m'

statement="Django Installation and setup successful - NOW RUN COMMAND 'python manage.py runserver' "


terminal_width=$(tput cols)

num_asterisks=$(( (terminal_width - ${#statement}) / 2 - 1))

printf "%${terminal_width}s\n" | tr ' ' '*'

printf "%${num_asterisks}s${GREEN}${BOLD}%s${RESET}%${num_asterisks}s\n" "" "$statement" ""

printf "%${terminal_width}s\n" | tr ' ' '*'

