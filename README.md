# Django React Docker Template

## Introduction

This is a local development template repository for Django and React applications using Docker Compose. The intended use is to speed up the development setup and provide a structured environment for building web applications with Django as the backend and React as the frontend.

**Important: This template is designed solely for local development. It is not configured for deployment and is NOT production-ready. Please avoid using this setup in a production environment without significant modifications and security considerations.**

This template aims to streamline the initial setup process, allowing developers to focus on building features rather than configuring their environments. With this template, you can quickly get started on your projects, experiment with new ideas, and enhance your skills in web development using Django and React.

## Features

- **Dockerized Setup**: Easily manage your development environment with Docker and Docker Compose.
- **Seamless Integration**: Pre-configured setup for Django REST Framework and React.
- **Environment Management**: Simplified management of dependencies and configurations using Poetry and Node.js package management.
- **Hot Reloading**: Enable hot reloading for React during development for a smoother development experience.
- **Automated Migrations**: Automatically apply database migrations upon container startup.
- **Automated Super User Creation**: Automatically creates a super user Username: `admin` Password: `admin` upon container startup.

## Main Frameworks/Libraries/Packages

Please see `backend/pyproject.toml`/`backend/poetry.lock` and `frontend/package.json` for full details.

### Django

- Django v5.1.1
- Django Rest Framework

### React

- Create React App
- Node dev server via Docker LTS alpine image
- Hot reload

### Postgres

- Docker v16.1 alpine image

## Forking and Using as a Template

You're welcome to fork this repository, but using it as a template may be more beneficial for your projects. Here’s how to set it up as a project template:

1. Create a new GitHub repository.
2. On your local development machine, navigate to your preferred parent directory and run:
   ```bash
   git clone https://github.com/loganengle/django-react-docker-boilerplate.git <your-new-local-repo>
   cd <your-new-local-repo>
   git remote set-url origin <url-of-new-repo>
   git push -u origin main
   ```

## Configuration

**The envfile provided in this repository `.env.example` is merely an example - make sure you replace this with your actual `.env` file**

It is expected that there is a legitimate envfile named `.env` as the `docker-compose.yml` relies on it:

### Useful Commands

**Build containers** - Add `--up` flag to bring services up after build
```bash
docker-compose build
```

**Bring Containers Up**
```bash
docker-compose up
```

**Bring Containers Down**
```bash
docker-compose down
```

**View Logs For Specific Container**
```bash
docker-compose logs <service-name>
```

**Enter Shell For Specific Container** - Must be running
```bash
docker exec -it <container-name> sh
```

## Containers, Services and Ports

| Container | Service  | Host Port | Docker Port |
|-----------|----------|-----------|-------------|
| django    | django   | 8000      | 8000        |
| react     | react    | 3000      | 3000        |
| postgres  | postgres | 5432      | 5432        |


## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you have suggestions or improvements.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Django](https://www.djangoproject.com/)
- [React](https://reactjs.org/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)