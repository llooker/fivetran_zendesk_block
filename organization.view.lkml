view: organization {
  sql_table_name: zendesk.organization ;;

  # Just as agents can be segmented into groups in Zendesk Support, your customers (end-users)
  # can be segmented into organizations. You can manually assign customers to an organization
  # or automatically assign them to an organization by their email address domain. Organizations
  # can be used in business rules to route tickets to groups of agents or to send email notifications.

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

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: details {
    type: string
    sql: ${TABLE}.details ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

# ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      group.name,
      group.id,
      organization_member.count,
      organization_tag.count,
      ticket.count,
      user.count
    ]
  }

#   dimension: external_id {
#     type: string
#     sql: ${TABLE}.external_id ;;
#   }
#
#   dimension: shared_comments {
#     type: yesno
#     sql: ${TABLE}.shared_comments ;;
#   }
#
#   dimension: shared_tickets {
#     type: yesno
#     sql: ${TABLE}.shared_tickets ;;
#   }
#
#   dimension_group: updated {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.updated_at ;;
#   }
#
#   dimension_group: created {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}.created_at ;;
#   }
#
#   dimension: url {
#     type: string
#     sql: ${TABLE}.url ;;
#   }
}
