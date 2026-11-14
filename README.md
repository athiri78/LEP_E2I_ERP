# Énergie Renouvelable Photovoltaïque – UCD
> LPE : Électronique et Informatique Industrielle (E2I)  
> Université Chouaib Doukkali – Faculté des Sciences El Jadida  
> Département de Physique

## 🌐 Site en ligne

```
https://athiri78.github.io/plateforme-physique/
```

## 📋 Description

Plateforme pédagogique destinée aux étudiants de la filière **LPE : Électronique et Informatique Industrielle (E2I)**. Elle comprend :

- 📝 **Évaluation QCM** – 20 questions interactives sur 5 chapitres avec correction automatique
- 📚 **Cours & TD** – Consultation et téléchargement des supports pédagogiques PDF
- 🔬 **Travaux Pratiques** – Énoncés PDF, fichiers MATLAB/Simulink et Excel
- ⚙️ **Espace Admin** – Gestion des ressources et des évaluations (accès protégé)

## 🛠️ Stack technique

| Composant | Technologie |
|-----------|-------------|
| Framework | React 18 + Vite |
| Styles | TailwindCSS |
| Routing | React Router DOM v6 |
| Math | KaTeX |
| Backend | Supabase (BDD + Auth + Storage) |
| Hébergement | GitHub Pages |
| CI/CD | GitHub Actions |

## 🚀 Installation et démarrage

### 1. Cloner le dépôt

```bash
git clone https://github.com/athiri78/plateforme-physique.git
cd plateforme-physique
```

### 2. Installer les dépendances

```bash
npm install
```

### 3. Configurer Supabase

Créez un fichier `.env` à la racine :

```env
VITE_SUPABASE_URL=https://votre-projet.supabase.co
VITE_SUPABASE_ANON_KEY=votre-cle-anonyme
```

### 4. Initialiser la base de données

Exécutez le fichier `supabase-schema.sql` dans l'éditeur SQL de votre projet Supabase.

### 5. Démarrer en développement

```bash
npm run dev
```

### 6. Build de production

```bash
npm run build
```

## 📂 Structure du projet

```
plateforme-physique/
├── src/
│   ├── components/        # Composants réutilisables
│   ├── pages/             # Pages principales
│   ├── admin/             # Espace administrateur
│   ├── services/          # Supabase + Storage
│   ├── hooks/             # Custom React hooks
│   └── styles/            # CSS global
├── .github/workflows/     # CI/CD GitHub Actions
├── supabase-schema.sql    # Schéma de base de données
└── vite.config.js
```

## 🗄️ Configuration Supabase

### Base de données

| Table | Description |
|-------|-------------|
| `chapters` | 5 chapitres du programme |
| `questions` | Banque de questions QCM |
| `resources` | Cours, TD, TP (métadonnées) |
| `evaluations` | Configuration des évaluations |
| `student_results` | Notes et résultats |

### Stockage

Créez un bucket `resources` (public) dans Supabase Storage.

## 🔐 Déploiement GitHub Pages

### 1. Configurer les secrets GitHub

Dans votre dépôt GitHub : **Settings > Secrets and variables > Actions**

Ajoutez :
- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`

### 2. Activer GitHub Pages

**Settings > Pages > Source > GitHub Actions**

### 3. Pousser sur `main`

```bash
git add .
git commit -m "Initial deployment"
git push origin main
```

Le déploiement est automatique via GitHub Actions.

## 👤 Accès administrateur

1. Créez un utilisateur dans Supabase : **Authentication > Users > Add user**
2. Accédez à `/admin/login`
3. Connectez-vous avec l'email et le mot de passe créés

## 📧 Contact

Département de Physique – Faculté des Sciences El Jadida  
Université Chouaib Doukkali
