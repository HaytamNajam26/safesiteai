# Stage 1: Build Flutter app
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Copier tous les fichiers nécessaires
COPY pubspec.yaml ./
COPY analysis_options.yaml ./

# Copier pubspec.lock s'il existe
COPY pubspec.lock* ./

# Installer les dépendances
RUN flutter pub get

# Configurer le projet pour le web
RUN flutter create . --platforms web

# Copier le code source
COPY lib ./lib

# Copier les assets (le dossier peut être vide)
COPY assets ./assets

# Construire l'application web
RUN flutter build web --release

# Stage 2: Serveur web Nginx
FROM nginx:alpine

# Copier les fichiers buildés depuis le stage précédent
COPY --from=build /app/build/web /usr/share/nginx/html

# Copier la configuration Nginx personnalisée (optionnel)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposer le port
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]

