PLATEFORME PHOTOVOLTAÏQUE – VERSION AVEC TÉLÉVERSEMENT DIRECT

1. Copiez index.html, resources.json et le dossier files/ à la racine du dépôt GitHub Pages.
2. Le dossier files/ contient cours/, td/ et tp/. Le téléversement automatique les remplira.
3. Pour activer l'envoi depuis l'administration, déployez le Cloudflare Worker fourni dans le dossier cloudflare-worker-github-upload.
4. Suivez le guide README_FR.txt du Worker. Configurez l'URL du Worker dans la constante RESOURCE_UPLOAD_API de index.html.
5. Publiez index.html et resources.json dans le dépôt GitHub.

Dans l'administration, sélectionnez Cours, TD ou TP, saisissez un titre, choisissez un fichier, sélectionnez son format et entrez le code ADMIN_UPLOAD_PASSWORD défini dans les Secrets Cloudflare. Le fichier sera téléversé dans le dossier correspondant et resources.json sera mis à jour automatiquement.

Formats acceptés : Cours PDF ; TD/TP PDF, MATLAB (.m), Simulink (.slx), Excel (.xlsx/.xls). Limite 15 Mo.
Aucun lien Google Drive ou OneDrive n'est utilisé.
