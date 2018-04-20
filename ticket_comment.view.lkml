view: ticket_comment {
  view_label: "Ticket Comments"

  derived_table: {
    sql: SELECT *, row_number() over (partition by ticket_id order by created asc) as comment_sequence
          FROM zendesk.ticket_comment ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: body {
    type: string
    sql: ${TABLE}.body ;;
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
    sql: ${TABLE}.created ;;
  }

  dimension: public {
    type: yesno
    description: "Can the customer see this comment?"
    sql: ${TABLE}.public ;;
  }

  dimension: ticket_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ticket_id ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: facebook_comment {
    type: yesno
    sql: ${TABLE}.facebook_comment ;;
  }

  dimension: tweet {
    type: yesno
    sql: ${TABLE}.tweet ;;
  }

  dimension: voice_comment {
    type: yesno
    sql: ${TABLE}.voice_comment ;;
  }

  dimension: comment_sequence {
    type: number
    sql: ${TABLE}.comment_sequence ;;
  }

  measure: count {
    type: count
    drill_fields: [ticket.id, commenter.name, commenter.is_internal, public, created_time, comment_sequence, body]
  }
}
