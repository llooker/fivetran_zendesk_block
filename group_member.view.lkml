view: group_member {
  sql_table_name: zendesk.group_member ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.group_id ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }
}
