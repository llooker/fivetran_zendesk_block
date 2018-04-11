view: __extends {
  derived_table: {
    sql: SELECT
          ticket_id
          ,MAX(case when field_name = 'status' then updated else null end) AS last_updated_status
          ,MAX(case when field_name = 'assignee_id' then updated else null end) AS last_updated_by_assignee
          ,MAX(case when field_name = 'requester_id' then updated else null end) AS last_updated_by_requester
          ,MAX(case when field_name = 'solved' then updated else null end) AS solved
          ,MIN(case when field_name = 'assignee_id' then updated else null end) AS initially_assigned
          ,SUM(case when field_name = 'assignee_id' then 1 else 0 end) - 1 as number_of_assignee_changes
          ,count(distinct case when field_name = 'assignee_id' then value else null end) as number_of_distinct_assignees
          ,count(distinct case when field_name = 'group_id' then value else null end) as number_of_distinct_groups
      FROM zendesk.ticket_field_history
      where ticket_id = 974
      GROUP BY ticket_id
      limit 10
       ;;
  }

  dimension: ticket_id {
    type: number
    sql: ${TABLE}.ticket_id ;;
  }

  dimension_group: last_updated_status {
    type: time
    sql: ${TABLE}.last_updated_status ;;
  }

  dimension_group: last_updated_by_assignee {
    type: time
    sql: ${TABLE}.last_updated_by_assignee ;;
  }

  dimension_group: last_updated_by_requester {
    type: time
    sql: ${TABLE}.last_updated_by_requester ;;
  }

  dimension_group: solved {
    type: time
    sql: ${TABLE}.solved ;;
  }

  dimension_group: initially_assigned {
    type: time
    sql: ${TABLE}.initially_assigned ;;
  }

  dimension: number_of_assignee_changes {
    type: number
    sql: ${TABLE}.number_of_assignee_changes ;;
  }

  dimension: number_of_distinct_assignees {
    type: number
    sql: ${TABLE}.number_of_distinct_assignees ;;
  }

  dimension: number_of_distinct_groups {
    type: number
    sql: ${TABLE}.number_of_distinct_groups ;;
  }

}
