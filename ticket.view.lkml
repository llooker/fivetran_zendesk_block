include: "_variables.view"

view: ticket {
  extends: [_variables]
  sql_table_name: zendesk.ticket ;;

  # ----- database fields -----
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    html: <img src="http://www.google.com/s2/favicons?domain=www.zendesk.com" height=16 width=16> {{ value }} ;;
    link: {
      label: "Zendesk Ticket"
      url: "https://{{ ticket._ZENDESK_INSTANCE_DOMAIN._value }}.zendesk.com/agent/tickets/{{ value }}"
      icon_url: "https://d1eipm3vz40hy0.cloudfront.net/images/logos/zendesk-favicon.ico"
    }
    link: {
      label: "Zendesk Ticket Detail"
      url: "https://{{ ticket._LOOKER_INSTANCE_DOMAIN._value }}.looker.com/dashboards/{{ ticket._ZENDESK_TICKET_DETAIL_DASHBOARD_ID._value }}?Ticket={{ value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: id_direct_link {
    type: number
    sql: ${id} ;;
    html: <a href="https://{{ ticket._ZENDESK_INSTANCE_DOMAIN._value }}.zendesk.com/agent/tickets/{{ value }}" target="_blank"><img src="http://www.google.com/s2/favicons?domain=www.zendesk.com" height=16 width=16> {{ value }}</a> ;;
    hidden: yes
  }

  dimension: allow_channelback {
    type: yesno
    sql: ${TABLE}.allow_channelback ;;
    description: "Is false if channelback is disabled, true otherwise. Only applicable for channels framework ticket"
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    description: "The first comment on the ticket"
  }

  dimension: has_incidents {
    type: yesno
    sql: ${TABLE}.has_incidents ;;
  }

  dimension: is_public {
    type: yesno
    sql: ${TABLE}.is_public ;;
  }

  dimension: priority {
    type: string
    sql: case when LOWER(${TABLE}.priority) = 'low' then '2 - Low'
          when LOWER(${TABLE}.priority) = 'normal' then '3 - Normal'
          when LOWER(${TABLE}.priority) = 'high' then '4 - High'
          when LOWER(${TABLE}.priority) = 'urgent' then '5 - Urgent'
          when LOWER(${TABLE}.priority) is null then '1 - Not Assigned' end ;;
    description: "The urgency with which the ticket should be addressed. Possible values: urgent, high, normal, low"
    html: {% if value == '1 - Not Assigned' %}
            <div style="color: black; background-color: grey; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '2 - Low' %}
            <div style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '3 - Normal' %}
            <div style="color: black; background-color: yellow; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '4 - High' %}
            <div style="color: white; background-color: darkred; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '5 - Urgent' %}
            <div style="color: white; background-color: black; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% else %}
            <div style="color: black; background-color: blue; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% endif %}
    ;;
  }

  dimension: recipient {
    type: string
    sql: ${TABLE}.recipient ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    description: "The state of the ticket"
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.`type` ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: via_channel {
    type: string
    sql: ${TABLE}.via_channel ;;
  }

  dimension: via_source_from_title {
    type: string
    sql: ${TABLE}.via_source_from_title ;;
  }

  dimension: via_source_rel {
    type: string
    sql: ${TABLE}.via_source_rel ;;
  }

  # ----- date attributes ------
  dimension_group: created {
    type: time
    timeframes: [
      raw,
      day_of_week,
      hour_of_day,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: create_time_of_day_tier {
    type: tier
    sql: ${created_hour_of_day} ;;
    tiers: [0, 4, 8, 12, 16, 20, 24]
    style: integer
  }

  dimension_group: last_updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_at ;;
  }

  dimension_group: due {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.due_at ;;
  }

  # ----- looker fields -----
  dimension: is_resolved {
    type: yesno
    sql: ${status} = ${_TICKET_STATUS_CLOSED} ;;
  }

  dimension: days_to_solve {
    type: number
    sql: 1.00 * DATE_DIFF(${ticket_history_facts.solved_date}, ${created_date}, DAY) ;;
  }

  dimension: days_to_first_response {
    type: number
    sql: 1.00 * DATE_DIFF(${ticket_history_facts.first_response_date}, ${created_date}, DAY) ;;
  }

  dimension: minutes_to_first_response {
    type: number
    sql: 1.00 * DATETIME_DIFF(EXTRACT(DATETIME FROM ${ticket_history_facts.first_response_raw}), EXTRACT(DATETIME FROM ${created_raw}), MINUTE) ;;
  }

  dimension: hours_to_solve {
    type: number
    sql: 1.00 * DATETIME_DIFF(${ticket_history_facts.solved_raw}, ${created_raw}, HOUR) ;;
  }

  dimension: is_responded_to {
    type: yesno
    sql: ${minutes_to_first_response} is not null ;;
  }

  dimension: days_since_updated {
    type: number
    sql: 1.00 * DATE_DIFF(${_CURRENT_DATE}, ${last_updated_date}, DAY)  ;;
    html: {% if value > 60 %}
            <div style="color: white; background-color: darkred; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% else %}
            <div style="color: black; background-color: yellow; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% endif %}
      ;;
  }

  measure: avg_days_to_solve {
    type: average
    sql: ${days_to_solve} ;;
    value_format_name: decimal_2
  }

  dimension: is_backlogged {
    type: yesno
    sql: ${status} = 'pending' ;;
    description: "If ticket is pending"
  }

  dimension: is_new {
    type: yesno
    sql: ${status} = 'new' ;;
    description: "If ticket is new"
  }

  dimension: is_open {
    type: yesno
    sql: ${status} = 'open' ;;
    description: "If ticket is open"
  }

  ### THIS ASSUMES NO DISTINCTION BETWEEN SOLVED AND CLOSED
  dimension: is_solved {
    type: yesno
    sql: ${status} = 'solved' OR ${status} = 'closed' ;;
  }


  dimension: subject_category {
    sql: CASE
      WHEN ${subject} LIKE 'Chat%' THEN 'Chat'
      WHEN ${subject} LIKE 'Offline message%' THEN 'Offline Message'
      WHEN ${subject} LIKE 'Phone%' THEN 'Phone Call'
      ELSE 'Other'
      END
       ;;
  }

  measure: count_backlogged_tickets {
    group_label: "Counts"
    type: count
    filters: {
      field: is_backlogged
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: count_new_tickets {
    group_label: "Counts"
    type: count
    filters: {
      field: is_new
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: count_open_tickets {
    group_label: "Counts"
    type: count
    filters: {
      field: is_open
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: count_solved_tickets {
    group_label: "Counts"
    type: count
    filters: {
      field: is_solved
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: avg_minutes_to_response {
    type: average
    sql: ${minutes_to_first_response} ;;
    value_format_name: decimal_0
  }


  # ----- measures ------
  measure: count {
    group_label: "Counts"
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      organization.name,
      ticket_comment.count,
      ticket_field_history.count,
      ticket_tag.count,
      ticket_tag_history.count
    ]
  }

  # ----- ID fields for joining  ------

  dimension: organization_id {
    type: number
    hidden: yes
    sql: ${TABLE}.organization_id ;;
  }

  dimension: problem_id {
    type: number
    hidden: yes
    sql: ${TABLE}.problem_id ;;
  }

  dimension: requester_id {
    type: number
    hidden: yes
    sql: ${TABLE}.requester_id ;;
  }

  dimension: submitter_id {
    type: number
    hidden: yes
    sql: ${TABLE}.submitter_id ;;
  }

  dimension: ticket_form_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ticket_form_id ;;
  }

  dimension: via_source_from_id {
    type: number
    hidden: yes
    sql: ${TABLE}.via_source_from_id ;;
  }

  dimension: external_id {
    type: string
    hidden: yes
    sql: ${TABLE}.external_id ;;
  }

  dimension: forum_topic_id {
    type: number
    hidden: yes
    sql: ${TABLE}.forum_topic_id ;;
  }

  dimension: group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.group_id ;;
  }

  dimension: assignee_id {
    type: number
    hidden: yes
    sql: ${TABLE}.assignee_id ;;
  }

  dimension: brand_id {
    type: number
    hidden: yes
    sql: ${TABLE}.brand_id ;;
  }
}
