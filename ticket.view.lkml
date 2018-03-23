view: ticket {
  sql_table_name: zendesk.ticket ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: _fivetran_synced {
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
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: allow_channelback {
    type: yesno
    sql: ${TABLE}.allow_channelback ;;
  }

  dimension: assignee_id {
    type: number
    sql: ${TABLE}.assignee_id ;;
  }

  dimension: brand_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.brand_id ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: custom_github_issue {
    type: string
    sql: ${TABLE}.custom_github_issue ;;
  }

  dimension: custom_relevant_integration {
    type: string
    sql: ${TABLE}.custom_relevant_integration ;;
  }

  dimension: custom_ticket_type {
    type: string
    sql: ${TABLE}.custom_ticket_type ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
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

  dimension: external_id {
    type: string
    sql: ${TABLE}.external_id ;;
  }

  dimension: forum_topic_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.forum_topic_id ;;
  }

  dimension: group_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.group_id ;;
  }

  dimension: has_incidents {
    type: yesno
    sql: ${TABLE}.has_incidents ;;
  }

  dimension: is_public {
    type: yesno
    sql: ${TABLE}.is_public ;;
  }

  dimension: organization_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.organization_id ;;
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.priority ;;
  }

  dimension: problem_id {
    type: number
    sql: ${TABLE}.problem_id ;;
  }

  dimension: recipient {
    type: string
    sql: ${TABLE}.recipient ;;
  }

  dimension: requester_id {
    type: number
    sql: ${TABLE}.requester_id ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }

  dimension: submitter_id {
    type: number
    sql: ${TABLE}.submitter_id ;;
  }

  dimension: ticket_form_id {
    type: number
    sql: ${TABLE}.ticket_form_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension_group: updated {
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

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: via_channel {
    type: string
    sql: ${TABLE}.via_channel ;;
  }

  dimension: via_source_from_id {
    type: number
    sql: ${TABLE}.via_source_from_id ;;
  }

  dimension: via_source_from_title {
    type: string
    sql: ${TABLE}.via_source_from_title ;;
  }

  dimension: via_source_rel {
    type: string
    sql: ${TABLE}.via_source_rel ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      forum_topic.name,
      forum_topic.id,
      brand.name,
      brand.id,
      group.name,
      group.id,
      organization.name,
      organization.id,
      ticket_comment.count,
      ticket_field_history.count,
      ticket_tag.count,
      ticket_tag_history.count
    ]
  }
}
