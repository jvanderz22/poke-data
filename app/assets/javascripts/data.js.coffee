ready = ( ->
  updateTeam = (id) ->
    $.ajax({
      url: '/data/' + id,
      type: 'GET',
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
