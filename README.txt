PLATEFORME PHOTOVOLTAÏQUE – INSTALLATION SUR GITHUB PAGES

1. Décompressez ce dossier.
2. Copiez index.html, resources.json et le dossier files/ à la racine de votre dépôt GitHub.
3. Dans files/, conservez les trois dossiers cours/, td/ et tp/.
4. Déposez vos documents dans le dossier correspondant :
   - files/cours/ : supports de cours PDF
   - files/td/    : énoncés TD PDF, scripts MATLAB, modèles Simulink, fichiers Excel
   - files/tp/    : protocoles TP PDF, scripts MATLAB, modèles Simulink, fichiers Excel
5. Ouvrez la page Administration sur le site.
6. Pour chaque document, indiquez sa catégorie, son titre, son format et son chemin relatif exact.
   Exemple : files/td/TD1.pdf
7. Cliquez sur « Télécharger resources.json ».
8. Remplacez le fichier resources.json à la racine du dépôt par le fichier téléchargé.
9. Faites Commit changes sur GitHub et attendez la mise à jour de GitHub Pages.

IMPORTANT
- Les pages Cours, TD et TP lisent le fichier public resources.json.
- L'ajout/suppression depuis l'administration modifie la liste dans le navigateur et prépare un nouveau resources.json.
  Pour publier les modifications auprès de tous les étudiants, il faut remplacer resources.json dans GitHub.
- La suppression d'une ressource dans l'administration retire son entrée de la liste, mais ne supprime pas le fichier du dépôt.
- Aucun lien Google Drive ou OneDrive n'est utilisé.
- GitHub Pages ne permet pas à un formulaire HTML statique d'écrire directement dans le dépôt GitHub sans mécanisme d'authentification côté serveur.
