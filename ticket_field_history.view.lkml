view: ticket_field_history {
  sql_table_name: zendesk.ticket_field_history ;;

  dimension: field_name {
    type: string
    sql: ${TABLE}.field_name ;;
  }

  dimension: ticket_id {
    type: number
    hidden: yes
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

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }

}
