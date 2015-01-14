$(document).ready(function() {
  checkbox = function(id, type) {
    label = type.charAt(0).toUpperCase() + type.slice(1)
    return '<label for="battle_user_team_pokemon_team_pokemon' + id + '_' + type + '">' + label +
    '</label> <input name="battle[user_team][pokemon_team][pokemon' + id +  '_' + type + ']" type="hidden" value="0">' +
    '<input id="battle_user_team_pokemon_team_pokemon' + id + '_' + type + '" name="battle[opponent_team][pokemon_team][pokemon' + id +
    '_' + type + ']" type="checkbox" value="1">'
  }
  pokemonHTML = function(pokemon) {
    var html = ""
    for (i = 0; i < 6; i++) {
      var id = i + 1
      var name;
      if (pokemon[i] != null) {
        name = pokemon[i].name
      }
      else {
        name = ''
      }
      html = html + '<div class="pokemon"><label>Pokemon: </label>' +
      '<input id="battle_user_team_pokemon_team' + id +
      '" name="battle[user_team][pokemon_team][pokemon' + id +
      ']" type="text" value="' + name + '" class="disabled" disabled>' +
      checkbox(id, 'lead') + checkbox(id, 'back') + "</div>"
    }
    return html
  }
  updateTeam = function(id) {
    $.ajax({
      url: '/user_teams/' + id,
      type: 'GET',
      success: function(data) {
        $('.pokemon-list').html(pokemonHTML(data.pokemon))
      }
    })
  }

  $("#battle_selected_team_id").change(function() {
    var id = $(this).val()
    updateTeam(id)
  })


  $.ajax({
    url: '/session',
    type: 'GET',
    success: function(data) {
      user_team_id = data['user_team_id']
      updateTeam(user_team_id)
      $("#battle_selected_team_id").val(user_team_id)
    }
  })
})
