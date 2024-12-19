# Install_in_NutShell

## Introduction

**Install_in_NutShell** est un projet conçu pour automatiser l'installation d'outils essentiels tels que **Visual Studio Code**, **Teams** et **Docker** sur un PC Windows via un script PowerShell. De plus, il intègre des workflows CI/CD avec GitHub Actions pour déployer un site web frontend et backend sur Azure Web App Services.

## Fonctionnalités

- **Installation automatisée d'outils** :
  - Visual Studio Code
  - Teams
  - Docker

- **Workflows CI/CD** :
  - Vérification des commits
  - Exécution des tests unitaires
  - Déploiement et mise à jour des scripts dans la base de données
  - Déploiement en préproduction et production du site web de téléchargement

## Prérequis

- **Système d'exploitation** : Windows
- **PowerShell** : Version 5.0 ou supérieure
- **Accès internet** pour télécharger les outils
- **Compte Azure** pour le déploiement du site web

## Installation

1. **Cloner le dépôt** :
   ```bash
   git clone https://github.com/termimi/Install_in_NutShell.git
   ```

2. **Exécuter le script PowerShell** en tant qu'administrateur :
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope Process
   .\install.ps1
   ```

   Le script installera automatiquement les outils mentionnés.

## Utilisation

- **Script PowerShell** : Exécutez `install.ps1` pour installer les outils souhaités.
- **Workflows CI/CD** : Les workflows GitHub Actions automatisent le processus de déploiement et de mise à jour du site web.

## Déploiement sur Azure

Les workflows CI/CD sont configurés pour déployer automatiquement le site web sur Azure Web App Services. Assurez-vous que les secrets nécessaires (tels que les identifiants Azure) sont correctement configurés dans les paramètres du dépôt GitHub.

## Captures d'écran

![Interface du site web](./screenshots/interface_site_web.png)

![image](https://github.com/user-attachments/assets/c5217612-f9be-4789-a529-0b7f767f11ca)

## Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. **Forkez le dépôt**.
2. **Créez une branche** pour votre fonctionnalité :
   ```bash
   git checkout -b feature/ma-fonctionnalite
   ```
3. **Commitez vos modifications** :
   ```bash
   git commit -m "Ajout de ma fonctionnalité"
   ```
4. **Poussez vers le dépôt distant** :
   ```bash
   git push origin feature/ma-fonctionnalite
   ```
5. **Ouvrez une Pull Request**.

## Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](./LICENSE) pour plus de détails.

---

*Dernière mise à jour : 19 décembre 2024*

