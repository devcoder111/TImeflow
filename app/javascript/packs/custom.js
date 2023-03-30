$(document).on('turbolinks:load', function () {

  $('[data-toggle="slide-collapse"]').on('click', function () {
    $navMenuCont = $($(this).data('target'));
    $navMenuCont.animate({
      'width': 'toggle'
    }, 350);
    $(".menu-overlay").fadeIn(500);

  });

  $(".menu-overlay").click(function (event) {
    $(".navbar-toggle").trigger("click");
    $(".menu-overlay").fadeOut(500);
  });
  $("form").on("click", ".remove_fields", function (event) {
    $(this).prev("input[type=hidden]").val("1");
    $(this).closest("fieldset").hide();
    return event.preventDefault();
  });
  $("form").on("click", ".add_fields", function (event) {
    try {
      var regexp, time;
      time = new Date().getTime();
      regexp = new RegExp($(this).data("id"), "g");
      $(this).before($(this).data("fields").replace(regexp, time));
      return event.preventDefault();
    }
    catch (err) {}
  });

  $(document).on('change', '.event_stream_dropdown', function (e) {
    const element_number = $(this).attr('id').split('_')[4]

    if (this.value === null || this.value === '') {
      $('#event_definition_fields_' + element_number).html('')
    }
    else {
      $.get("/event_definitions/" + this.value, { element_number: element_number})
    }
    return event.preventDefault();
  });

  $(document).on('change', '#event_stream_monitor', function (e) {
    if (this.value === null || this.value === '')
      $('#event_definition_fields').html('')
    else
      $.get("/event_definition_monitor/" + this.value);
    return event.preventDefault();
  });

  $(document).on('change', '#simulation_type', function (e) {
    if (this.value === 'Run Once' || this.value === 'Run Continously')
      $('#simulation_type_value').addClass('d-none')
    else
      $('#simulation_type_value').removeClass('d-none')
    return event.preventDefault();
  });

  $(document).on('cocoon:after-insert', '#simulation_fields', function (e) {
    const inputs = $(this).find('input');
    const i = $(inputs).length - 1;
    const el1 = $(inputs)[i];
    const number = $(el1).attr('id').split('_')[4];
    const divs = $(this).find('div.event_definition_fields');
    const j = $(divs).length - 1;
    const el2 = $(divs)[j];
    $(el2).attr('id', 'event_definition_fields_' + number)
  });

  $(document).on('click', '#preview_btn', function (e) {
    const event_stream_id = $('#event_stream_monitor').val();

    if (event_stream_id === null || event_stream_id === '') {
      alert("Please select an event stream");
    }
    const name = $('#time_flow_monitor_name').val();
    const description = $('#time_flow_monitor_description').val();

    const url = new URL(window.location.href);
    const datastring = $("#monitors").serialize();
    const id = url.pathname.split('/')[4]

    const project_id = url.pathname.split('/')[2]
    $.get("/projects/" + project_id + "/monitors/" + id + "/preview?" + datastring, { event_stream_id: event_stream_id})
      .done(function (data) {
        $("#preview_arrow").show();
      });

    return event.preventDefault();
  });

  $(document).on('click', '#alert_btn', function (e) {
    $("#alert_table").show();
    $("#alert_arrow").show();
    return event.preventDefault();
  });

  $(document).on('change', '.new_report_event_stream', function (e) {
    const event_stream_id = $(this).val();
    const element_number = $(this).attr('id').split('_')[4];

    if (this.value === null || this.value === '') {
      $('#new_report_event_stream_columns_' + element_number).html('')
    }
    else {
      $.get("/projects/" + gon.project_id + "/reports/event_stream_fields", { element_number: element_number, event_stream_id: event_stream_id })
    }
    return event.preventDefault();
  });

  $(document).on('cocoon:after-insert', '#report_items', function (e) {
    const inputs = $(this).find('input');
    const i = $(inputs).length - 1;
    const el1 = $(inputs)[i];
    const number = $(el1).attr('id').split('_')[4];
    const divs = $(this).find('tbody.new_report_event_stream_columns_0');
    console.log(el1)
    const j = $(divs).length - 1;
    const el2 = $(divs)[j];
    $(el2).attr('id', 'new_report_event_stream_columns_' + number)
  });

  var dataTable = null

  document.addEventListener("turbolinks:before-cache", function () {
    if (dataTable !== null) {
      dataTable.destroy()
      dataTable = null
    }
  })

});
