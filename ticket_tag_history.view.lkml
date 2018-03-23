view: ticket_tag_history {
  sql_table_name: zendesk.ticket_tag_history ;;

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

  dimension: tag {
    type: string
    sql: ${TABLE}.tag ;;
  }

  dimension: tagged {
    type: yesno
    sql: ${TABLE}.tagged ;;
  }

  dimension: ticket_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.ticket_id ;;
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
    sql: ${TABLE}.updated ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [user.id, user.custom_lead_or_contact_first_name, user.name, ticket.id]
  }
}
