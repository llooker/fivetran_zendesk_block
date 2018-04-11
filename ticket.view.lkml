include: "_variables.view"

view: ticket {
  extends: [_variables]
  sql_table_name: zendesk.ticket ;;

  # ----- database fields -----
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    link: {
      label: "Zendesk Ticket"
      url: "https://{{ ticket._ZENDESK_INSTANCE_DOMAIN._value }}.zendesk.com/agent/tickets/{{ value }}"
      icon_url: "https://d1eipm3vz40hy0.cloudfront.net/images/logos/zendesk-favicon.ico"
    }
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
    sql: ${TABLE}.priority ;;
    description: "The urgency with which the ticket should be addressed. Possible values: urgent, high, normal, low"
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

#   dimension: hours_to_solve {
#     type: number
#     sql: 1.00 * DATETIME_DIFF(${ticket_history_facts.solved_raw}, ${created_raw}, HOUR) ;;
#   }

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
    type: count
    filters: {
      field: is_backlogged
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: count_new_tickets {
    type: count
    filters: {
      field: is_new
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: count_open_tickets {
    type: count
    filters: {
      field: is_open
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: count_solved_tickets {
    type: count
    filters: {
      field: is_solved
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  # ----- measures ------
  measure: count {
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
