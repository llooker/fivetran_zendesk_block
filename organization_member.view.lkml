view: organization_member {
  sql_table_name: zendesk.organization_member ;;

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

  dimension: organization_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.organization_id ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      user.id,
      user.custom_lead_or_contact_first_name,
      user.name,
      organization.name,
      organization.id
    ]
  }
}
