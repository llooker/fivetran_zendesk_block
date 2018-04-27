include: "_zendesk_variables.view"

view: ticket {
  extends: [_variables]
  sql_table_name: zendesk.ticket ;;

  # ----- database fields -----
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    html: <img src="http://www.google.com/s2/favicons?domain=www.zendesk.com" height=16 width=16> {{ value }} ;;
    link: {
      label: "Zendesk Ticket"
      url: "https://{{ ticket._ZENDESK_INSTANCE_DOMAIN._value }}.zendesk.com/agent/tickets/{{ value }}"
      icon_url: "https://d1eipm3vz40hy0.cloudfront.net/images/logos/zendesk-favicon.ico"
    }
    link: {
      label: "Zendesk Ticket Detail"
      url: "https://{{ ticket._LOOKER_INSTANCE_DOMAIN._value }}.looker.com/dashboards/{{ ticket._ZENDESK_TICKET_DETAIL_DASHBOARD_ID._value }}?Ticket={{ value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: id_direct_link {
    type: number
    sql: ${id} ;;
    html: <a href="https://{{ ticket._ZENDESK_INSTANCE_DOMAIN._value }}.zendesk.com/agent/tickets/{{ value }}" target="_blank"><img src="http://www.google.com/s2/favicons?domain=www.zendesk.com" height=16 width=16> {{ value }}</a> ;;
    hidden: yes
  }

  dimension: allow_channelback {
    type: yesno
    sql: ${TABLE}.allow_channelback ;;
    description: "Is false if channelback is disabled, true otherwise. Only applicable for channels framework ticket"
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    description: "The first comment on the ticket"
  }

  dimension: has_incidents {
    type: yesno
    sql: ${TABLE}.has_incidents ;;
  }

  dimension: is_public {
    type: yesno
    sql: ${TABLE}.is_public ;;
  }

  dimension: priority {
    type: string
    sql: case when LOWER(${TABLE}.priority) = 'low' then '2 - Low'
          when LOWER(${TABLE}.priority) = 'normal' then '3 - Normal'
          when LOWER(${TABLE}.priority) = 'high' then '4 - High'
          when LOWER(${TABLE}.priority) = 'urgent' then '5 - Urgent'
          when LOWER(${TABLE}.priority) is null then '1 - Not Assigned' end ;;
    description: "The urgency with which the ticket should be addressed. Possible values: urgent, high, normal, low"
    html: {% if value == '1 - Not Assigned' %}
            <div style="color: black; background-color: grey; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '2 - Low' %}
            <div style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '3 - Normal' %}
            <div style="color: black; background-color: yellow; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '4 - High' %}
            <div style="color: white; background-color: darkred; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% elsif value == '5 - Urgent' %}
            <div style="color: white; background-color: black; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% else %}
            <div style="color: black; background-color: blue; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% endif %}
    ;;
  }

  dimension: recipient {
    type: string
    sql: ${TABLE}.recipient ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    description: "The state of the ticket"
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.`type` ;;
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: via_channel {
    type: string
    sql: ${TABLE}.via_channel ;;
  }

  dimension: via_source_from_title {
    type: string
    sql: ${TABLE}.via_source_from_title ;;
  }

  dimension: via_source_rel {
    type: string
    sql: ${TABLE}.via_source_rel ;;
  }

  # ----- date attributes ------
  dimension_group: created {
    type: time
    timeframes: [
      raw,
      day_of_week,
      hour_of_day,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: create_time_of_day_tier {
    type: tier
    sql: ${created_hour_of_day} ;;
    tiers: [0, 4, 8, 12, 16, 20, 24]
    style: integer
  }

  dimension_group: last_updated {
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
  }

  dimension_group: due {
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
    sql: ${TABLE}.due_at ;;
  }

  # ----- looker fields -----
  dimension: is_resolved {
    type: yesno
    sql: ${status} = ${_TICKET_STATUS_CLOSED} ;;
  }

  dimension: days_to_solve {
    type: number
    sql: 1.00 * DATE_DIFF(${ticket_history_facts.solved_date}, ${created_date}, DAY) ;;
  }

  dimension: days_to_first_response {
    type: number
    sql: 1.00 * DATE_DIFF(${ticket_history_facts.first_response_date}, ${created_date}, DAY) ;;
  }

  dimension: minutes_to_first_response {
    type: number
    sql: 1.00 * DATETIME_DIFF(EXTRACT(DATETIME FROM ${ticket_history_facts.first_response_raw}), EXTRACT(DATETIME FROM ${created_raw}), MINUTE) ;;
  }

  dimension: hours_to_solve {
    type: number
    sql: 1.00 * DATETIME_DIFF(${ticket_history_facts.solved_raw}, ${created_raw}, HOUR) ;;
  }

  dimension: is_responded_to {
    type: yesno
    sql: ${minutes_to_first_response} is not null ;;
  }

  dimension: days_since_updated {
    type: number
    sql: 1.00 * DATE_DIFF(${_CURRENT_DATE}, ${last_updated_date}, DAY)  ;;
    html: {% if value > 60 %}
            <div style="color: white; background-color: darkred; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% else %}
            <div style="color: black; background-color: yellow; font-size:100%; text-align:center">{{ rendered_value }}</div>
          {% endif %}
      ;;
  }

  measure: avg_days_to_solve {
    type: average
    sql: ${days_to_solve} ;;
    value_format_name: decimal_2
  }

  dimension: is_backlogged {
    type: yesno
    sql: ${status} = 'pending' ;;
    description: "If ticket is pending"
  }

  dimension: is_new {
    type: yesno
    sql: ${status} = 'new' ;;
    description: "If ticket is new"
  }

  dimension: is_open {
    type: yesno
    sql: ${status} = 'open' ;;
    description: "If ticket is open"
  }

  ### THIS ASSUMES NO DISTINCTION BETWEEN SOLVED AND CLOSED
  dimension: is_solved {
    type: yesno
    sql: ${status} = 'solved' OR ${status} = 'closed' ;;
  }


  dimension: subject_category {
    sql: CASE
      WHEN ${subject} LIKE 'Chat%' THEN 'Chat'
      WHEN ${subject} LIKE 'Offline message%' THEN 'Offline Message'
      WHEN ${subject} LIKE 'Phone%' THEN 'Phone Call'
      ELSE 'Other'
      END
       ;;
  }

  measure: count_backlogged_tickets {
    group_label: "Counts"
    type: count
    filters: {
      field: is_backlogged
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: count_new_tickets {
    group_label: "Counts"
    type: count
    filters: {
      field: is_new
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: count_open_tickets {
    group_label: "Counts"
    type: count
    filters: {
      field: is_open
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: count_solved_tickets {
    group_label: "Counts"
    type: count
    filters: {
      field: is_solved
      value: "Yes"
    }
    drill_fields: [detail*]
  }

  measure: avg_minutes_to_response {
    type: average
    sql: ${minutes_to_first_response} ;;
    value_format_name: decimal_0
  }


  # ----- measures ------
  measure: count {
    group_label: "Counts"
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      organization.name,
      ticket_comment.count,
      ticket_field_history.count,
      ticket_tag.count,
      ticket_tag_history.count
    ]
  }

  # ----- ID fields for joining  ------

  dimension: organization_id {
    type: number
    hidden: yes
    sql: ${TABLE}.organization_id ;;
  }

  dimension: problem_id {
    type: number
    hidden: yes
    sql: ${TABLE}.problem_id ;;
  }

  dimension: requester_id {
    type: number
    hidden: yes
    sql: ${TABLE}.requester_id ;;
  }

  dimension: submitter_id {
    type: number
    hidden: yes
    sql: ${TABLE}.submitter_id ;;
  }

  dimension: ticket_form_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ticket_form_id ;;
  }

  dimension: via_source_from_id {
    type: number
    hidden: yes
    sql: ${TABLE}.via_source_from_id ;;
  }

  dimension: external_id {
    type: string
    hidden: yes
    sql: ${TABLE}.external_id ;;
  }

  dimension: forum_topic_id {
    type: number
    hidden: yes
    sql: ${TABLE}.forum_topic_id ;;
  }

  dimension: group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.group_id ;;
  }

  dimension: assignee_id {
    type: number
    hidden: yes
    sql: ${TABLE}.assignee_id ;;
  }

  dimension: brand_id {
    type: number
    hidden: yes
    sql: ${TABLE}.brand_id ;;
  }
}

view: user {
  extends: [_variables]
  sql_table_name: zendesk.user ;;
  extension: required

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: organization_id {
    type: number
    hidden: yes
    sql: ${TABLE}.organization_id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: name {
    label: "{% if  _view._name == 'assignee' %} {{'Assignee Name'}} {% elsif _view._name == 'commenter' %} {{ 'Commenter Name'}} {% else %} {{ 'Requester Name'}} {% endif %} "
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
}

view: commenter {
  extends: [user]

  dimension: is_internal {
    type: yesno
    description: "Is an internal user?"
    sql: ${organization_id} = ${_INTERNAL_ORGANIZATION_ID} ;;
  }
}

view: assignee {
  extends: [user]

  dimension: name {
    label: "{% if  _view._name == 'assignee' %} {{'Assignee Name'}} {% elsif _view._name == 'commenter' %} {{ 'Commenter Name'}} {% else %} {{ 'Requester Name'}} {% endif %} "
    type: string
    sql: ${TABLE}.name ;;
    link: {
      label: "{{ value }}'s Dashboard"
      url: "https://{{ ticket._LOOKER_INSTANCE_DOMAIN._value }}.looker.com/dashboards/{{ ticket._ZENDESK_AGENT_PERFORMANCE_DASHBOARD_ID._value }}?Agent%20Name={{ value }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }

  dimension: chat_only {
    type: yesno
    sql: ${TABLE}.chat_only ;;
  }

  dimension: moderator {
    type: yesno
    sql: ${TABLE}.moderator ;;
  }

  dimension: shared_agent {
    type: yesno
    sql: ${TABLE}.shared_agent ;;
  }

  dimension: restricted_agent {
    type: yesno
    sql: ${TABLE}.restricted_agent ;;
  }

  # ----- agent comparison fields -----
  filter: agent_select {
    view_label: "Agent Comparisons"
    suggest_dimension: user.name
  }

  dimension: agent_comparitor {
    view_label: "Agent Comparisons"
    sql:
    CASE
      WHEN {% condition agent_select %} ${name} {% endcondition %}
      THEN ${name}
      ELSE CONCAT(' ', 'All Other Agents')
    END ;;
  }
}

view: requester {
  extends: [user]
  # The user who is asking for support through a ticket is the requester.

  dimension: locale {
    type: string
    sql: ${TABLE}.locale ;;
  }

  dimension_group: last_login {
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
    sql: ${TABLE}.last_login_at ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  dimension: time_zone {
    type: string
    sql: ${TABLE}.time_zone ;;
  }

}

view: ticket_comment {
  view_label: "Ticket Comments"

  derived_table: {
    sql: SELECT *, row_number() over (partition by ticket_id order by created asc) as comment_sequence
      FROM zendesk.ticket_comment ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: body {
    type: string
    sql: ${TABLE}.body ;;
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
    sql: ${TABLE}.created ;;
  }

  dimension: public {
    type: yesno
    description: "Can the customer see this comment?"
    sql: ${TABLE}.public ;;
  }

  dimension: ticket_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ticket_id ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: facebook_comment {
    type: yesno
    sql: ${TABLE}.facebook_comment ;;
  }

  dimension: tweet {
    type: yesno
    sql: ${TABLE}.tweet ;;
  }

  dimension: voice_comment {
    type: yesno
    sql: ${TABLE}.voice_comment ;;
  }

  dimension: comment_sequence {
    type: number
    sql: ${TABLE}.comment_sequence ;;
  }

  measure: count {
    type: count
    drill_fields: [ticket.id, commenter.name, commenter.is_internal, public, created_time, comment_sequence, body]
  }
}

view: ticket_field_history {
  sql_table_name: zendesk.ticket_field_history ;;

  dimension: field_name {
    type: string
    sql: ${TABLE}.field_name ;;
  }

  dimension: ticket_id {
    type: number
    hidden: yes
    sql: ${TABLE}.ticket_id ;;
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
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }
}

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
}

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

view: brand {
  view_label: "Ticket"
  sql_table_name: zendesk.brand ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: name {
    label: "Brand"
    type: string
    sql: ${TABLE}.name ;;
    description: "Brands are your customer-facing identities. They might represent multiple products or services, or they might literally be multiple brands owned and represented by your company."
  }
}

view: ticket_history_facts {
  view_label: "Ticket"
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
