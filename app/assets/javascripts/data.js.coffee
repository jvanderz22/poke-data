ready = ( ->
  updateTeam = (id) ->
    $.ajax({
      url: '/data/' + id,
      type: 'GET',
      success: (data) ->
        $('.pokemon-list').html(pokemonHTML(data.pokemon))
    })

  $("#selected_team_selected_team_id").change( ->
    console.log('change')
    id = $(this).val()
    console.log(id)
    updateTeam(id)
  )

)
$(document).ready(ready)
$(document).on('page:load', ready)
