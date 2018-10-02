@app.directive 'ngWelcome', ->
  template :"<h1>Bienvenue {{user.nom}} {{user.prenom}} ! <small>Votre solde de congé est : {{user.solde}} </small></h1>"
