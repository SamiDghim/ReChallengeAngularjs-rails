@app.directive 'ngWelcome', ->
  scope : {
    user: "="
  }
  template :"
  <p> Bienvenue
  {{user.nom}} {{user.prenom}} !
   Votre solde de congé est :
     <span style='font-size: larger; color:white' class='badge badge-warning' >{{user.solde}}</span>
      </p>"
