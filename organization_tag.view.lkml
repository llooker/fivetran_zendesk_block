view: organization_tag {
  sql_table_name: zendesk.organization_tag ;;

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

  dimension: organization_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.organization_id ;;
  }

  dimension: tag {
    type: string
    sql: ${TABLE}.tag ;;
  }

  measure: count {
    type: count
    drill_fields: [organization.name, organization.id]
  }
}
