include: "_variables.view"

view: ticket_history_facts {
  view_label: "Ticket"
#   extends: [_variables]
  derived_table: {
    sql: SELECT
          tfh.ticket_id
          ,IFNULL(tc.created, MAX(case when field_name = 'status' and value = 'solved' then updated else null end)) as first_response
          ,MAX(case when field_name = 'status' then updated else null end) AS last_updated_status
          ,MAX(case when field_name = 'assignee_id' then updated else null end) AS last_updated_by_assignee
          ,MAX(case when field_name = 'requester_id' then updated else null end) AS last_updated_by_requester
          ,MAX(case when field_name = 'status' and value = 'solved' then updated else null end) AS solved
          ,MAX(updated) AS updated
          ,MIN(case when field_name = 'assignee_id' then updated else null end) AS initially_assigned
          ,SUM(case when field_name = 'assignee_id' then 1 else 0 end) as number_of_assignee_changes
          ,count(distinct case when field_name = 'assignee_id' then value else null end) as number_of_distinct_assignees
          ,count(distinct case when field_name = 'group_id' then value else null end) as number_of_distinct_groups

      FROM zendesk.ticket_field_history as tfh
      LEFT JOIN (
          SELECT ticket_id, created, row_number() over (partition by ticket_id order by created asc) as comment_sequence
          FROM zendesk.ticket_comment
      ) tc on tc.ticket_id = tfh.ticket_id and tc.comment_sequence = 2
      GROUP BY ticket_id, tc.created ;;
  }

  dimension: test {
    type: string
#     hidden: yes
    sql: 'closed' ;;
  }

  dimension_group: first_response {
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
    sql: ${TABLE}.first_response ;;
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
    description: "Number of distinct groups for a ticket"
  }

  measure: total_number_of_distinct_assignees {
    group_label: "Distinct Assignees"
    type: sum
    sql: ${number_of_distinct_assignees} ;;
  }

  measure: average_number_of_distinct_assignees {
    group_label: "Distinct Assignees"
    type: average
    sql: ${number_of_distinct_assignees} ;;
    value_format_name: decimal_2
  }

  measure: median_number_of_distinct_assignees {
    group_label: "Distinct Assignees"
    type: median
    sql: ${number_of_distinct_assignees} ;;
  }

  measure: total_number_of_assignee_changes {
    group_label: "Assignee Changes"
    type: sum
    sql: ${number_of_assignee_changes} ;;
  }

  measure: avg_number_of_assignee_changes {
    group_label: "Assignee Changes"
    type: average
    sql: ${number_of_assignee_changes} ;;
    value_format_name: decimal_2
  }

  measure: median_number_of_assignee_changes {
    group_label: "Assignee Changes"
    type: median
    sql: ${number_of_assignee_changes} ;;
  }

  measure: total_number_of_distinct_groups {
    group_label: "Distinct Groups"
    type: sum
    sql: ${number_of_distinct_groups} ;;
  }

  measure: avg_number_of_distinct_groups {
    group_label: "Distinct Groups"
    type: average
    sql: ${number_of_distinct_groups} ;;
    value_format_name: decimal_2
  }

  measure: median_number_of_distinct_groups {
    group_label: "Distinct Groups"
    type: median
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
    group_label: "Reopens"
    type: sum
    sql: ${number_of_reopens} ;;
  }

  measure: avg_number_of_reopens {
    group_label: "Reopens"
    type: average
    sql: ${number_of_reopens} ;;
    value_format_name: decimal_2
  }

  measure: median_number_of_reopens {
    group_label: "Reopens"
    type: median
    sql: ${number_of_reopens} ;;
  }
}

# view: ticket_comment_facts {}

view: ticket_assignee_facts {
  view_label: "Assignee"
  derived_table: {
    sql: SELECT
        assignee_id
        , count(*) as lifetime_tickets
        , min(created_at) as first_ticket
        , max(created_at) as latest_ticket
        , 1.0 * COUNT(*) / NULLIF(DATE_DIFF(CURRENT_DATE, MIN(EXTRACT(date from created_at)), day), 0) AS avg_tickets_per_day
      FROM zendesk.ticket
      GROUP BY 1
       ;;
  }

  dimension: assignee_id {
    primary_key: yes
    sql: ${TABLE}.assignee_id ;;
    hidden: yes
  }

  dimension: lifetime_tickets {
    type: number
    value_format_name: id
    sql: ${TABLE}.lifetime_tickets ;;
  }

  dimension_group: first_ticket {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.first_ticket ;;
  }

  dimension_group: latest_ticket {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.latest_ticket ;;
  }

  dimension: avg_tickets_per_day {
    type: number
    sql: ${TABLE}.avg_tickets_per_day ;;
  }

  measure: total_lifetime_tickets {
    type: sum
    sql: ${lifetime_tickets} ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [assignee_id, lifetime_tickets, first_ticket_time, latest_ticket_time, avg_tickets_per_day]
  }
}
