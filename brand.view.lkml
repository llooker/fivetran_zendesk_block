view: brand {
  sql_table_name: zendesk.brand ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: _fivetran_deleted {
    type: yesno
    sql: ${TABLE}._fivetran_deleted ;;
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

  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
  }

  dimension: brand_url {
    type: string
    sql: ${TABLE}.brand_url ;;
  }

  dimension: default {
    type: yesno
    sql: ${TABLE}.`default` ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: subdomain {
    type: string
    sql: ${TABLE}.subdomain ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, ticket.count]
  }
}
