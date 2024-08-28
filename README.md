## Sports League Viewer

Sports League Viewer est une application conçue pour permettre aux utilisateurs de rechercher et explorer des ligues sportives de manière intuitive et interactive.

### Fonctionnalités

	•	Recherche de ligues sportives : Les utilisateurs peuvent facilement rechercher des ligues sportives via un champ de recherche avec auto-complétion.
	•	Sélection de la ligue : Une fois qu’une ligue est sélectionnée, l’application affiche les équipes participant au championnat de cette ligue.
	•	Affichage des équipes : Les équipes sont présentées dans un ordre anti-alphabétique, avec un filtrage qui n’affiche qu’une équipe sur deux.

### Architecture

Le projet est structuré selon le pattern MVVM et suit les principes de la Clean Architecture. Cette approche permet de maintenir un codebase modulaire, testable et facile à maintenir.

### Dépendances

Le projet utilise Swift Package Manager (SPM) pour la gestion des dépendances, avec la couche réseau encapsulée dans un package séparé.
Tests Unitaires

### API

L’application s’appuie sur les données fournies par l’API de TheSportsDB.
