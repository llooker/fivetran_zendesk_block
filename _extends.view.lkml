include: "_variables.view"

view: ticket_history_facts {
  view_label: "Ticket"
#   extends: [_variables]
  derived_table: {
    sql: SELECT
          ticket_id
          ,MAX(case when field_name = 'status' then updated else null end) AS last_updated_status
          ,MAX(case when field_name = 'assignee_id' then updated else null end) AS last_updated_by_assignee
          ,MAX(case when field_name = 'requester_id' then updated else null end) AS last_updated_by_requester
          ,MAX(case when field_name = 'status' and value = 'solved' then updated else null end) AS solved
          ,MAX(updated) AS updated
          ,MIN(case when field_name = 'assignee_id' then updated else null end) AS initially_assigned
          ,SUM(case when field_name = 'assignee_id' then 1 else 0 end) as number_of_assignee_changes
          ,count(distinct case when field_name = 'assignee_id' then value else null end) as number_of_distinct_assignees
          ,count(distinct case when field_name = 'group_id' then value else null end) as number_of_distinct_groups

      FROM zendesk.ticket_field_history
      GROUP BY ticket_id ;;
  }

  dimension: test {
    type: string
#     hidden: yes
    sql: 'closed' ;;
  }

  dimension: ticket_id {
    type: number
    sql: ${TABLE}.ticket_id ;;
    hidden: yes
    primary_key: yes
  }

  dimension_group: last_updated_status {
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
    sql: ${TABLE}.last_updated_status ;;
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
    hidden: yes
    # why is this not = to the field on ticket on some occasions? should be redundant.
  }

  dimension_group: last_updated_by_assignee {
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
    sql: ${TABLE}.last_updated_by_assignee ;;
  }

  dimension_group: last_updated_by_requester {
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
    sql: ${TABLE}.last_updated_by_requester ;;
  }

  dimension_group: solved {
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
    sql: ${TABLE}.solved ;;
  }

  dimension_group: initially_assigned {
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
    sql: ${TABLE}.initially_assigned ;;
  }

  dimension: number_of_assignee_changes {
    type: number
    sql: ${TABLE}.number_of_assignee_changes ;;
    description: "Number of times the assignee changed for a ticket (including initial assignemnt)"
  }

  dimension: number_of_distinct_assignees {
    type: number
    sql: ${TABLE}.number_of_distinct_assignees ;;
    description: "Number of distinct assignees for a ticket"
  }

  dimension: number_of_distinct_groups {
    type: number
    sql: ${TABLE}.number_of_distinct_groups ;;
  }

  measure: total_number_of_distinct_assignees {
    type: sum
    sql: ${number_of_distinct_assignees} ;;
  }

  measure: total_number_of_assignee_changes {
    type: sum
    sql: ${number_of_assignee_changes} ;;
  }

  measure: total_number_of_distinct_groups {
    type: sum
    sql: ${number_of_distinct_groups} ;;
  }
}

view: number_of_reopens {
  view_label: "Ticket"
  derived_table: {
    sql:  WITH grouped_ticket_status_history AS (
            SELECT *
            FROM zendesk.ticket_field_history
            WHERE field_name = 'status'
            ORDER BY ticket_id, updated
         ),
         statuses AS (
            SELECT
                ticket_id,
                LAG(ticket_id, 1, 0) OVER(ORDER BY ticket_id, updated) AS prev_ticket_id,
                value AS status,
                LAG(value, 1, 'new') OVER(ORDER BY ticket_id, updated) AS prev_status
            FROM grouped_ticket_status_history
         )
         SELECT
             DISTINCT ticket_id,
             COUNT(ticket_id) AS number_of_reopens
         FROM statuses
         WHERE ticket_id = prev_ticket_id AND prev_status = 'solved' AND status = 'open'
         GROUP BY ticket_id ;;
  }

  dimension: ticket_id {
    type: number
    sql: ${TABLE}.ticket_id ;;
    hidden: yes
    primary_key: yes
  }

  dimension: number_of_reopens {
    type: number
    sql: ${TABLE}.number_of_reopens ;;
    description: "Number of times the ticket was reopened"
  }

  measure: total_number_of_reopens {
    type: sum
    sql: ${number_of_reopens} ;;
  }
}


# view: last_updated_by_requester {
#   derived_table: {
#     sql: SELECT
#         ticket_id,
#         MAX(updated) AS last_updated_by_requester
#     FROM zendesk.ticket_field_history
#     WHERE field_name = 'requester_id'
#     GROUP BY ticket_id ;;
#   }
#
#   dimension: ticket_id {
#     type: number
#     sql: ${TABLE}.ticket_id ;;
#     hidden: yes
#     primary_key: yes
#   }
#
#   dimension_group: last_updated_by_requester {
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
#     sql: ${TABLE}.last_updated_by_requester ;;
#   }
# }

# view: last_updated_by_assignee {
#   derived_table: {
#     sql: SELECT
#         ticket_id,
#         MAX(updated) AS last_updated_by_assignee
#     FROM zendesk.ticket_field_history
#     WHERE field_name = 'requester_id'
#     GROUP BY ticket_id ;;
#   }
#
#   dimension: ticket_id {
#     type: number
#     sql: ${TABLE}.ticket_id ;;
#     hidden: yes
#     primary_key: yes
#   }
#
#   dimension_group: last_updated_by_assignee {
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
#     sql: ${TABLE}.last_updated_by_assignee ;;
#   }
# }

# view: last_updated_status {
#   derived_table: {
#     sql: SELECT
#         ticket_id,
#         MAX(updated) AS last_updated_status
#     FROM zendesk.ticket_field_history
#     WHERE field_name = 'status'
#     GROUP BY ticket_id ;;
#   }
#
#   dimension: ticket_id {
#     type: number
#     sql: ${TABLE}.ticket_id ;;
#     hidden: yes
#     primary_key: yes
#   }
#
#   dimension_group: last_updated_status {
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
#     sql: ${TABLE}.last_updated_status ;;
#   }
# }

# view: number_of_assignees {
#   derived_table: {
#     sql: SELECT
#           ticket_id,
#           COUNT(distinct value) AS number_of_assignees
#       FROM zendesk.ticket_field_history
#       WHERE field_name = 'assignee_id'
#       GROUP BY ticket_id ;;
#   }
#
#   dimension: ticket_id {
#     type: number
#     sql: ${TABLE}.ticket_id ;;
#     hidden: yes
#     primary_key: yes
#   }
#
#   dimension: number_of_assignees {
#     type: number
#     sql: ${TABLE}.number_of_assignees ;;
#     description: "Number of distinct assignees for a ticket"
#   }
#
#   measure: total_number_of_assignees {
#     type: sum
#     sql: ${number_of_assignees} ;;
#   }
# }
