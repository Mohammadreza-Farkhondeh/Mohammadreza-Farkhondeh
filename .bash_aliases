alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'
alias h='history'
alias e='exit'
alias update='sudo apt update && sudo apt upgrade -y'
alias clear_pycache='find . | grep -E "(/__pycache__$|\.pyc$|\.pyo$)" | xargs rm -rf'

alias clear_tool_cache='rm -rf .idea .ruff_cache .pytest_cache .mypy_cache .tox .coverage .cache'

alias backup='function _backup() { tar -czvf $1.tar.gz $1; }; _backup'
alias extract='function _extract() { tar -xzvf $1; }; _extract'
alias search='function _search() { grep -rnw . -e $1; }; _search'
alias monitor='watch -n 1 "free -m; df -h; top -b -n 1 | head -n 20"'

alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

alias dps='docker ps'
alias di='docker images'
alias dstop='docker stop $(docker ps -a -q)'
alias drm='docker rm $(docker ps -a -q)'
alias drmi='docker rmi $(docker images -q)'

alias docker_build_run='function _docker_build_run() { docker build -t $1 . && docker run -d -p $2:$3 $1; }; _docker_build_run'

alias venv='python3 -m venv .venv'
alias activate='source .venv/bin/activate'
alias deactivate='deactivate'

alias conda_activate='conda activate'
alias conda_deactivate='conda deactivate'
alias conda_create='function _conda_create() { conda create -n $1 python=$2; }; _conda_create'
alias conda_remove='function _conda_remove() { conda remove -n $1 --all; }; _conda_remove'
alias conda_list='conda env list'

alias new_py_project='function _new_py_project() { mkdir -p $1 && cd $1 && python3 -m venv .venv && source .venv/bin/activate && touch main.py && echo "print(\"Hello, World!\")" > main.py && touch requirements.txt && echo "# Add your dependencies here" > requirements.txt; }; _new_py_project'

alias run_py='function _run_py() { source .venv/bin/python $1; }; _run_py'

# Alias for creating a new Django project with best practices and Docker support
alias new_django_project='function _new_django_project() {
    project_name=$1
    mkdir -p $project_name
    cd $project_name
    python3 -m venv .venv
    source .venv/bin/activate
    pip install django djangorestframework django-cors-headers gunicorn python-dotenv
    django-admin startproject $project_name .
    mkdir -p $project_name/{apps,settings}
    mv $project_name/settings.py $project_name/settings/base.py
    touch $project_name/settings/{development.py,production.py}
    echo -e "from .base import *\n\nDEBUG = True\n\nALLOWED_HOSTS = os.getenv('ALLOWED_HOSTS', '').split(',')\n\nDATABASES = {\n    'default': {\n        'ENGINE': 'django.db.backends.sqlite3',\n        'NAME': BASE_DIR / 'db.sqlite3',\n    }\n}\n" > $project_name/settings/development.py
    echo -e "from .base import *\n\nDEBUG = False\n\nALLOWED_HOSTS = os.getenv('ALLOWED_HOSTS', '').split(',')\n\nDATABASES = {\n    'default': {\n        'ENGINE': 'django.db.backends.postgresql',\n        'NAME': os.getenv('DB_NAME'),\n        'USER': os.getenv('DB_USER'),\n        'PASSWORD': os.getenv('DB_PASSWORD'),\n        'HOST': os.getenv('DB_HOST'),\n        'PORT': os.getenv('DB_PORT'),\n    }\n}\n" > $project_name/settings/production.py
    echo -e "import os\nfrom pathlib import Path\nfrom dotenv import load_dotenv\n\nload_dotenv()\n\nBASE_DIR = Path(__file__).resolve().parent.parent\n\nSECRET_KEY = os.getenv('SECRET_KEY')\n\nINSTALLED_APPS = [\n    'django.contrib.admin',\n    'django.contrib.auth',\n    'django.contrib.contenttypes',\n    'django.contrib.sessions',\n    'django.contrib.messages',\n    'django.contrib.staticfiles',\n    'rest_framework',\n    'corsheaders',\n]\n\nMIDDLEWARE = [\n    'corsheaders.middleware.CorsMiddleware',\n    'django.middleware.security.SecurityMiddleware',\n    'django.contrib.sessions.middleware.SessionMiddleware',\n    'django.middleware.common.CommonMiddleware',\n    'django.middleware.csrf.CsrfViewMiddleware',\n    'django.contrib.auth.middleware.AuthenticationMiddleware',\n    'django.contrib.messages.middleware.MessageMiddleware',\n    'django.middleware.clickjacking.XFrameOptionsMiddleware',\n]\n\nROOT_URLCONF = '$project_name.urls'\n\nTEMPLATES = [\n    {\n        'BACKEND': 'django.template.backends.django.DjangoTemplates',\n        'DIRS': [],\n        'APP_DIRS': True,\n        'OPTIONS': {\n            'context_processors': [\n                'django.template.context_processors.debug',\n                'django.template.context_processors.request',\n                'django.contrib.auth.context_processors.auth',\n                'django.contrib.messages.context_processors.messages',\n            ],\n        },\n    },\n]\n\nWSGI_APPLICATION = '$project_name.wsgi.application'\n\nAUTH_PASSWORD_VALIDATORS = [\n    {\n        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',\n    },\n    {\n        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',\n    },\n    {\n        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',\n    },\n    {\n        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',\n    },\n]\n\nLANGUAGE_CODE = 'en-us'\n\nTIME_ZONE = 'UTC'\n\nUSE_I18N = True\n\nUSE_TZ = True\n\nSTATIC_URL = '/static/'\n\nDEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'\n\nCORS_ALLOWED_ORIGINS = os.getenv(\"CORS_ALLOWED_ORIGINS\", \"\").split(\",\")\n" > $project_name/settings/base.py
    echo -e "SECRET_KEY=\"your-secret-key\"\nDB_NAME=\"your-db-name\"\nDB_USER=\"your-db-user\"\nDB_PASSWORD=\"your-db-password\"\nDB_HOST=\"your-db-host\"\nDB_PORT=\"your-db-port\"\nALLOWED_HOSTS=\"localhost,127.0.0.1\"\nCORS_ALLOWED_ORIGINS=\"http://localhost:3000\"\nDJANGO_SUPERUSER_USERNAME=\"admin\"\nDJANGO_SUPERUSER_PASSWORD=\"adminpassword\"\nDJANGO_SUPERUSER_EMAIL=\"admin@example.com\"\n" > .env
    echo -e "from django.urls import path, include\nfrom django.contrib import admin\n\nurlpatterns = [\n    path('admin/', admin.site.urls),\n    path('api/', include('rest_framework.urls')),\n]\n" > $project_name/urls.py
    echo -e "web: gunicorn $project_name.wsgi:application\n" > Procfile
    echo -e "venv/\n__pycache__/\n*.pyc\n*.pyo\n.idea/\n.ruff_cache/\n.pytest_cache/\n.mypy_cache/\n.tox/\n.coverage/\n.cache/\n.env\n" > .gitignore
    echo -e "# $project_name\n\n## Setup\n\n1. Create a virtual environment and activate it:\n\n\`\`\`bash\npython3 -m venv venv\nsource venv/bin/activate\n\`\`\`\n\n2. Install dependencies:\n\n\`\`\`bash\npip install -r requirements.txt\n\`\`\`\n\n3. Run the application:\n\n\`\`\`bash\npython manage.py runserver\n\`\`\`" > README.md
    echo -e "djangorestframework\ndjango-cors-headers\ngunicorn\npython-dotenv\n" > requirements.txt
    echo -e "FROM python:3.9-slim\n\nWORKDIR /app\n\nCOPY requirements.txt requirements.txt\nRUN pip install -r requirements.txt\n\nCOPY . .\n\nCMD [\"/entrypoint.sh\"]\n" > Dockerfile
    echo -e "#!/bin/bash\n\n# Collect static files\necho \"Collect static files\"\npython manage.py collectstatic --noinput\n\n# Apply database migrations\necho \"Apply database migrations\"\npython manage.py migrate\n\n# Create default admin user\nif [ -n \"$DJANGO_SUPERUSER_USERNAME\" ] && [ -n \"$DJANGO_SUPERUSER_PASSWORD\" ] && [ -n \"$DJANGO_SUPERUSER_EMAIL\" ]; then\n    python manage.py createsuperuser --noinput --username \"$DJANGO_SUPERUSER_USERNAME\" --email \"$DJANGO_SUPERUSER_EMAIL\" || true\nfi\n\n# Start server\necho \"Starting server\"\ngunicorn --bind 0.0.0.0:8000 $project_name.wsgi:application\n" > entrypoint.sh
    chmod +x entrypoint.sh
    echo "Project $project_name created successfully!"
}; _new_django_project'


alias new_fastapi_project='function _new_fastapi_project() {
    project_name=$1
    mkdir -p $project_name/app/{routers,models,schemas,dependencies}
    touch $project_name/app/{__init__.py,main.py,routers/__init__.py,models/__init__.py,schemas/__init__.py,dependencies/__init__.py}
    echo "from fastapi import FastAPI\n\napp = FastAPI()\n\n@app.get(\"/\")\ndef read_root():\n    return {\"Hello\": \"World\"}" > $project_name/app/main.py
    echo "from fastapi import APIRouter\n\nrouter = APIRouter()\n\n@router.get(\"/items/\")\ndef read_items():\n    return [\"item1\", \"item2\"]" > $project_name/app/routers/items.py
    cd $project_name
    python3 -m venv .venv
    source .venv/bin/activate
    pip install fastapi uvicorn
    echo -e \"fastapi\nuvicorn\" > requirements.txt
    echo -e \"__pycache__/\n*.pyc\n*.pyo\nvenv/\n.idea/\n.ruff_cache/\n.pytest_cache/\n.mypy_cache/\n.tox/\n.coverage/\n.cache/\" > .gitignore
    echo \"# $project_name\n\n## Setup\n\n1. Create a virtual environment and activate it:\n\n\`\`\`bash\npython3 -m venv venv\nsource venv/bin/activate\n\`\`\`\n\n2. Install dependencies:\n\n\`\`\`bash\npip install -r requirements.txt\n\`\`\`\n\n3. Run the application:\n\n\`\`\`bash\nuvicorn app.main:app --reload\n\`\`\`\" > README.md
    echo \"Project $project_name created successfully!\"
}; _new_fastapi_project'

alias dns_reset='sudo bash -c "echo -e \"nameserver 172.26.146.34\nnameserver 172.26.146.35\" > /etc/resolv.conf"'
alias dns_shecan='sudo bash -c "echo -e \"nameserver 178.22.122.100\nnameserver 185.51.200.2\" > /etc/resolv.conf"'
alias dns_403='sudo bash -c "echo -e \"nameserver 10.202.10.202\nnameserver 10.202.10.102\" > /etc/resolv.conf"'
alias dns_electron='sudo bash -c "echo -e \"nameserver 78.157.42.101\nnameserver 78.157.42.102\" > /etc/resolv.conf"'
alias dns_google='sudo bash -c "echo -e \"nameserver 8.8.8.8\nnameserver 8.8.4.4\" > /etc/resolv.conf"'
alias dns_cloudflare='sudo bash -c "echo -e \"nameserver 1.1.1.1\nnameserver 1.0.0.1\" > /etc/resolv.conf"'
alias dns_quad9='sudo bash -c "echo -e \"nameserver 9.9.9.9\nnameserver 149.112.112.112\" > /etc/resolv.conf"'
alias dns_opendns='sudo bash -c "echo -e \"nameserver 208.67.222.222\nnameserver 208.67.220.220\" > /etc/resolv.conf"'
alias dns_adguard='sudo bash -c "echo -e \"nameserver 94.140.14.14\nnameserver 94.140.15.15\" > /etc/resolv.conf"'
alias dns_yandex='sudo bash -c "echo -e \"nameserver 77.88.8.8\nnameserver 77.88.8.1\" > /etc/resolv.conf"'
alias dns_verisign='sudo bash -c "echo -e \"nameserver 64.6.64.6\nnameserver 64.6.65.6\" > /etc/resolv.conf"'
alias dns_dnswatch='sudo bash -c "echo -e \"nameserver 84.200.69.80\nnameserver 84.200.70.40\" > /etc/resolv.conf"'


