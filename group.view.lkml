view: group {
  view_label: "Organization"
  sql_table_name: zendesk.`group` ;;

  # When support requests arrive in Zendesk Support, they can be assigned to a Group.
  # Groups serve as the core element of ticket workflow; support agents are organized into
  # Groups and tickets can be assigned to a Group only, or to an assigned agent within a Group.
  # A ticket can never be assigned to an agent without also being assigned to a Group.

  dimension: name {
    label: "Group"
    type: string
    sql: ${TABLE}.name ;;
    description: "When support requests arrive in Zendesk Support, they can be assigned to a Group."
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
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
    hidden: yes
  }

  dimension: deleted {
    type: yesno
    sql: ${TABLE}.deleted ;;
    hidden: yes
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
    hidden: yes
  }
}
