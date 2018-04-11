view: organization_member {
  sql_table_name: zendesk.organization_member ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: organization_id {
    type: number
    hidden: yes
    sql: ${TABLE}.organization_id ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }
}
