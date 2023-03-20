Le besoin:
1. pouvoir savoir depuis quand un compte est inactif

Les étapes:
1. Forcer l'utilisateur à se reconnecter après 4h d'inactivités, si la case "se souvenir de moi" n'est pas cochée
  Sécurité: forcer le renouvellement de la session permet de réduire les possiblités d'attaques:
  en effet, l'attaquant n'aurait plus que 4h pour utiliser le cookie de session volé
2. Faire en sorte que, lorsque l'utilisateur se (re-)connecte, on enregistre la date de connexion (last_sign_at)
  Voir soit le guide [Ruby On Railse](https://guides.rubyonrails.org/security.html#session-expiry), soit [StackOverFlow](https://stackoverflow.com/questions/43360349/can-you-use-devise-timeoutable-and-rememberable-at-the-same-time)
  Normalement, "trackable" met déjà à jour le champ self.current_sign_in_at et last_sign_in_at
3. Pour le confort de l'utilisateur, configurer le système pour que la case "se souvenir de moi" permette de renouveller automatiquement la session jusqu'à 30 jours maximum
4. Décider que tous les utilisateurs dont le last_sign_at date de plus de 3 ans sont des comptes inactifs

Avantage:
1. améliore la sécurité en réduisant la surface temporelle d'attaque
2. fait une mise à jour en base tous les 30 jours pour les utilisateurs (peut consomateur de resource) au lieu de le faire à chaque requête
