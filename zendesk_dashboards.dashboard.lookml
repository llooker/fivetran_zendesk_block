- dashboard: zendesk_overview
  title: Zendesk Overview
  layout: newspaper
  elements:
  - title: Total Tickets
    name: Total Tickets
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - ticket.count
    sorts:
    - ticket.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 0
    col: 0
    width: 5
    height: 3
  - title: Noisiest Customers
    name: Noisiest Customers
    model: zendesk_block
    explore: ticket
    type: looker_column
    fields:
    - ticket.count
    - organization.name
    filters:
      organization.name: "-NULL"
    sorts:
    - ticket.count desc
    limit: 10
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    show_dropoff: false
    listen:
      Ticket Created: ticket.created_date
    row: 6
    col: 0
    width: 11
    height: 7
  - title: Tickets by Day and Time
    name: Tickets by Day and Time
    model: zendesk_block
    explore: ticket
    type: table
    fields:
    - ticket.count
    - ticket.create_time_of_day_tier
    - ticket.created_day_of_week
    pivots:
    - ticket.created_day_of_week
    fill_fields:
    - ticket.created_day_of_week
    sorts:
    - ticket.create_time_of_day_tier
    - ticket.created_day_of_week
    limit: 20
    total: true
    row_total: right
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    show_dropoff: false
    series_types: {}
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: White to Green
        colors:
        - "#FFFFFF"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    listen:
      Ticket Created: ticket.created_date
    row: 13
    col: 0
    width: 13
    height: 6
  - title: Top Agents by Tickets Solved
    name: Top Agents by Tickets Solved
    model: zendesk_block
    explore: ticket
    type: looker_bar
    fields:
    - assignee.name
    - ticket.count_solved_tickets
    sorts:
    - ticket.count_solved_tickets desc
    limit: 10
    column_limit: 50
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    series_types: {}
    listen:
      Ticket Created: ticket.created_date
    row: 21
    col: 13
    width: 11
    height: 11
  - title: Agent Ticket Performance
    name: Agent Ticket Performance
    model: zendesk_block
    explore: ticket
    type: looker_column
    fields:
    - ticket.avg_days_to_solve
    - ticket.count
    - assignee.name
    filters:
      assignee.name: "-NULL"
    sorts:
    - assignee.name
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: ticket.avg_days_to_solve
        name: Ticket Avg Days to Solve
        axisId: ticket.avg_days_to_solve
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: ticket.count
        name: Ticket Count
        axisId: ticket.count
    series_types:
      ticket.avg_days_to_solve: line
    listen:
      Ticket Created: ticket.created_date
    row: 21
    col: 0
    width: 13
    height: 11
  - title: Tickets in 30 Days
    name: Tickets in 30 Days
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - ticket.count
    filters:
      ticket.created_date: 30 days
    sorts:
    - ticket.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 3
    col: 5
    width: 5
    height: 3
  - title: Tickets in 90 Days
    name: Tickets in 90 Days
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - ticket.count
    filters:
      ticket.created_date: 90 days
    sorts:
    - ticket.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 3
    col: 0
    width: 5
    height: 3
  - title: Averages
    name: Averages
    model: zendesk_block
    explore: ticket
    type: looker_column
    fields:
    - ticket.avg_days_to_solve
    - ticket.created_month
    - ticket_history_facts.avg_number_of_assignee_changes
    - number_of_reopens.avg_number_of_reopens
    fill_fields:
    - ticket.created_month
    sorts:
    - ticket.created_month
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: ticket_history_facts.avg_number_of_assignee_changes
        name: Ticket Avg Number of Assignee Changes
        axisId: ticket_history_facts.avg_number_of_assignee_changes
      - id: number_of_reopens.avg_number_of_reopens
        name: Ticket Avg Number of Reopens
        axisId: number_of_reopens.avg_number_of_reopens
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: ticket.avg_days_to_solve
        name: Ticket Avg Days to Solve
        axisId: ticket.avg_days_to_solve
    column_spacing_ratio:
    column_group_spacing_ratio:
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    series_types:
      ticket.avg_days_to_solve: line
    listen:
      Ticket Created: ticket.created_date
    row: 0
    col: 10
    width: 14
    height: 6
  - title: Tickets Over Time
    name: Tickets Over Time
    model: zendesk_block
    explore: ticket
    type: looker_column
    fields:
    - ticket.count
    - ticket.is_solved
    - ticket.created_month
    pivots:
    - ticket.is_solved
    fill_fields:
    - ticket.is_solved
    - ticket.created_month
    sorts:
    - ticket.is_solved 0
    - ticket.count desc 0
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    series_labels:
      No - ticket.count: Open
      Yes - ticket.count: Solved
    column_group_spacing_ratio:
    listen:
      Ticket Created: ticket.created_date
    row: 6
    col: 11
    width: 13
    height: 7
  - title: Stale Tickets
    name: Stale Tickets
    model: zendesk_block
    explore: ticket
    type: table
    fields:
    - ticket.id
    - ticket.created_date
    - ticket.priority
    - ticket.status
    - ticket_history_facts.number_of_assignee_changes
    - ticket.last_updated_date
    - ticket.days_since_updated
    filters:
      ticket.is_solved: 'No'
      ticket.created_date: before 30 days ago
      ticket.status: "-deleted"
    sorts:
    - ticket.days_since_updated desc
    limit: 10
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    row: 13
    col: 13
    width: 11
    height: 6
  - title: Not Responded Open Tickets
    name: Not Responded Open Tickets
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - ticket_comment.count
    filters:
      ticket.is_responded_to: 'No'
      ticket.is_solved: 'No'
    sorts:
    - ticket_comment.count desc
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    row: 0
    col: 5
    width: 5
    height: 3
  - name: Agent Performance
    type: text
    title_text: Agent Performance
    row: 19
    col: 0
    width: 24
    height: 2
  filters:
  - name: Ticket Created
    title: Ticket Created
    type: field_filter
    default_value: '2016'
    allow_multiple_values: true
    required: false
    model: zendesk_block
    explore: ticket
    listens_to_filters: []
    field: ticket.created_date

- dashboard: zendesk_agent_performance
  title: Zendesk Agent Performance
  layout: newspaper
  elements:
  - title: Tickets in 90 Days
    name: Tickets in 90 Days
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - ticket.count
    filters:
      ticket.created_date: 90 days
    sorts:
    - ticket.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Agent Name: assignee.name
    row: 3
    col: 0
    width: 5
    height: 3
  - title: Averages
    name: Averages
    model: zendesk_block
    explore: ticket
    type: looker_column
    fields:
    - ticket.avg_days_to_solve
    - ticket.created_month
    - ticket_history_facts.avg_number_of_assignee_changes
    - number_of_reopens.avg_number_of_reopens
    fill_fields:
    - ticket.created_month
    sorts:
    - ticket.created_month
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: ticket_history_facts.avg_number_of_assignee_changes
        name: Ticket Avg Number of Assignee Changes
        axisId: ticket_history_facts.avg_number_of_assignee_changes
      - id: number_of_reopens.avg_number_of_reopens
        name: Ticket Avg Number of Reopens
        axisId: number_of_reopens.avg_number_of_reopens
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: ticket.avg_days_to_solve
        name: Ticket Avg Days to Solve
        axisId: ticket.avg_days_to_solve
    column_spacing_ratio:
    column_group_spacing_ratio:
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    series_types:
      ticket.avg_days_to_solve: line
    listen:
      Agent Name: assignee.name
      Ticket Created: ticket.created_date
    row: 0
    col: 10
    width: 14
    height: 6
  - title: Total Tickets
    name: Total Tickets
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - ticket.count
    sorts:
    - ticket.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Agent Name: assignee.name
    row: 0
    col: 0
    width: 5
    height: 3
  - title: Not Responded Open Tickets
    name: Not Responded Open Tickets
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - ticket_comment.count
    filters:
      ticket.is_responded_to: 'No'
      ticket.is_solved: 'No'
    sorts:
    - ticket_comment.count desc
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Agent Name: assignee.name
    row: 0
    col: 5
    width: 5
    height: 3
  - title: Tickets in 30 Days
    name: Tickets in 30 Days
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - ticket.count
    filters:
      ticket.created_date: 30 days
    sorts:
    - ticket.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Agent Name: assignee.name
    row: 3
    col: 5
    width: 5
    height: 3
  - title: Avg Minutes to First Response
    name: Avg Minutes to First Response
    model: zendesk_block
    explore: ticket
    type: looker_bar
    fields:
    - assignee.agent_comparitor
    - ticket.avg_minutes_to_response
    filters:
      assignee.agent_select: ''
    sorts:
    - assignee.agent_comparitor desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: none
    interpolation: linear
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors:
    - red
    - blue
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    groupBars: true
    labelSize: 10pt
    showLegend: true
    font_size: '12'
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: bottom
      showLabels: false
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: ticket.avg_minutes_to_response
        name: Avg Minutes to Response
        axisId: ticket.avg_minutes_to_response
    listen:
      Agent Name: assignee.agent_select
    row: 6
    col: 0
    width: 12
    height: 6
  - title: Tickets Over Time
    name: Tickets Over Time
    model: zendesk_block
    explore: ticket
    type: looker_column
    fields:
    - ticket.count
    - ticket.is_solved
    - ticket.created_month
    pivots:
    - ticket.is_solved
    fill_fields:
    - ticket.is_solved
    - ticket.created_month
    sorts:
    - ticket.is_solved 0
    - ticket.count desc 0
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    series_labels:
      No - ticket.count: Open
      Yes - ticket.count: Solved
    column_group_spacing_ratio:
    listen:
      Agent Name: assignee.name
      Ticket Created: ticket.created_date
    row: 12
    col: 0
    width: 12
    height: 7
  - title: Stale Tickets
    name: Stale Tickets
    model: zendesk_block
    explore: ticket
    type: table
    fields:
    - ticket.id
    - ticket.created_date
    - ticket.priority
    - ticket.status
    - ticket_history_facts.number_of_assignee_changes
    - ticket.last_updated_date
    - ticket.days_since_updated
    filters:
      ticket.is_solved: 'No'
      ticket.created_date: before 30 days ago
      ticket.status: "-deleted"
    sorts:
    - ticket.days_since_updated desc
    limit: 10
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    listen:
      Agent Name: assignee.name
    row: 12
    col: 12
    width: 12
    height: 7
  - title: Avg Days to Solve
    name: Avg Days to Solve
    model: zendesk_block
    explore: ticket
    type: looker_bar
    fields:
    - assignee.agent_comparitor
    - ticket.avg_days_to_solve
    filters:
      assignee.agent_select: ''
    sorts:
    - assignee.agent_comparitor desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: none
    interpolation: linear
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    barColors:
    - red
    - blue
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    groupBars: true
    labelSize: 10pt
    showLegend: true
    font_size: '12'
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    colors:
    - 'palette: Mixed Dark'
    series_colors: {}
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: bottom
      showLabels: false
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: ticket.avg_days_to_solve
        name: Avg Days to Solve
        axisId: ticket.avg_days_to_solve
    listen:
      Agent Name: assignee.agent_select
    row: 6
    col: 12
    width: 12
    height: 6
  filters:
  - name: Agent Name
    title: Agent Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: zendesk_block
    explore: ticket
    listens_to_filters: []
    field: assignee.name
  - name: Ticket Created
    title: Ticket Created
    type: field_filter
    default_value: '2016'
    allow_multiple_values: true
    required: false
    model: zendesk_block
    explore: ticket
    listens_to_filters: []
    field: ticket.created_date

- dashboard: zendesk_ticket
  title: Zendesk Ticket
  layout: newspaper
  elements:
  - title: Customer
    name: Customer
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - organization.name
    sorts:
    - organization.name
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Ticket: ticket.id
    row: 0
    col: 0
    width: 5
    height: 2
  - title: Last Updated
    name: Last Updated
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - ticket_history_facts.last_updated_status_time
    sorts:
    - ticket_history_facts.last_updated_status_time desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: days_since_last_updated
      label: Days Since Last Updated
      expression: diff_days(${ticket_history_facts.last_updated_status_time}, now())
      value_format:
      value_format_name: decimal_0
      _kind_hint: dimension
      _type_hint: number
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Ticket: ticket.id
    row: 0
    col: 20
    width: 4
    height: 4
  - title: Assigned To
    name: Assigned To
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - assignee.name
    sorts:
    - assignee.name
    limit: 1
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Ticket: ticket.id
    row: 0
    col: 10
    width: 5
    height: 4
  - title: Requester
    name: Requester
    model: zendesk_block
    explore: ticket
    type: looker_single_record
    fields:
    - requester.name
    - requester.email
    - requester.last_login_time
    - requester.phone
    - requester.role
    - requester.time_zone
    - requester.notes
    sorts:
    - requester.name
    limit: 1
    column_limit: 50
    show_view_names: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Ticket: ticket.id
    row: 0
    col: 5
    width: 5
    height: 4
  - title: Status
    name: Status
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - ticket.status
    sorts:
    - ticket.status
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Ticket: ticket.id
    row: 0
    col: 15
    width: 5
    height: 4
  - title: Open in Zendesk
    name: Open in Zendesk
    model: zendesk_block
    explore: ticket
    type: single_value
    fields:
    - ticket.id_direct_link
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Ticket: ticket.id_direct_link
    row: 2
    col: 0
    width: 5
    height: 2
  - title: Comments
    name: Comments
    model: zendesk_block
    explore: ticket
    type: table
    fields:
    - ticket_comment.created_time
    - commenter.name
    - commenter.is_internal
    - ticket_comment.body
    sorts:
    - ticket_comment.created_time
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Ticket: ticket.id
    title_hidden: true
    row: 4
    col: 0
    width: 24
    height: 9
  filters:
  - name: Ticket
    title: Ticket
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: zendesk_block
    explore: ticket
    listens_to_filters: []
    field: ticket.id
