include: "ticket.view"

view: chat_fields {
  extends: [ticket]

############ CHAT FIELDS: INCLUDE ONLY IF YOUR ZENDESK APP UTILIZES CHAT ###########

  # Chat times are based off the 'description' column until Zopim's integration is updated. This is because
  # the timestamps Zopim uses are inconsistent w/r/t data structure and timezone conversions

  dimension: is_chat {
    type: yesno
    sql: POSITION('Chat started on ' IN ${description}) > 0 ;;
  }

  dimension: chat_start_time_string {
    hidden: yes
    sql: CASE
        WHEN POSITION('Chat started on ' IN ${description}) > 0
          THEN SUBSTRING(${description}, POSITION('Chat started on ' IN ${description}) + 16, 19)
      END
       ;;
  }

  dimension: chat_start_date_no_tz_convert {
    type: date
    hidden: yes
    convert_tz: no
    sql: CASE
        WHEN POSITION('PM' IN ${chat_start_time_string}) > 0 OR POSITION('AM' IN ${chat_start_time_string}) > 0
        THEN ${chat_start_time_string}::timestamp
      END
       ;;
  }

  dimension_group: chat_start {
    type: time
    timeframes: [
      date,
      week,
      month,
      time,
      day_of_week,
      hour_of_day
    ]
    sql: CASE
        WHEN POSITION('PM' IN ${chat_start_time_string}) > 0 OR POSITION('AM' IN ${chat_start_time_string}) > 0
        THEN ${chat_start_time_string}::timestamp
      END
       ;;
  }

  ## runs off the last time a comment was made by either a customer or an internal user
  # can be thrown off if customers stay on between separate chats
  dimension: chat_end_time_string {
    hidden: yes
    sql: CONCAT(${chat_start_date_no_tz_convert}, CONCAT(' ',
        LEFT(RIGHT(${description}, POSITION(')M' IN SUBSTRING(REVERSE(${description}),
            POSITION(')M' IN SUBSTRING(REVERSE(${description}), POSITION(')M' IN REVERSE(${description})) + 1, 10000)) +
            POSITION(')M' IN REVERSE(${description})) + 1, 10000)) +
                POSITION(')M' IN SUBSTRING(REVERSE(${description}), POSITION(')M' IN REVERSE(${description})) + 1, 10000)) +
                POSITION(')M' IN REVERSE(${description})) + 11), 11)
        )
      )
       ;;
  }

  dimension_group: chat_end {
    type: time
    timeframes: [date, time, hour_of_day]
    description: "As accurate as possible to when the chat \"ended\" but can be thrown off if customers staying on between separate chats."
    # assumes chats will not run from AM day 1 to AM day 2
    sql: CASE
        WHEN POSITION('PM' IN ${chat_start_time_string}) > 0  AND POSITION('AM' IN ${chat_end_time_string}) > 0
        THEN DATEADD(hour, 24, ${chat_end_time_string}::timestamp)
        ELSE ${chat_end_time_string}::timestamp
      END
       ;;
  }

  dimension: chat_duration_seconds {
    type: number
    #     hidden: true
    sql: DATEDIFF(second, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) ;;
  }

  dimension: chat_duration_minutes {
    description: "As accurate as possible to when the chat \"ended\" but can be thrown off if customers staying on between separate chats."
    type: number
    sql: ${chat_duration_seconds}/60 ;;
  }

  dimension: chat_duration_minutes_tier {
    #     hidden: true
    type: tier
    tiers: [
      0,
      5,
      10,
      20,
      40,
      60,
      80,
      100,
      120,
      140,
      160,
      180,
      200,
      300,
      400,
      500,
      600
    ]
    sql: ${chat_duration_minutes} ;;
  }

  ## Assumes working chat hours from 8am-6pm
  dimension: first_reply_time_chat {
    label: "First Reply Time (Chat)"
    description: "Time to first reponse; assumes chat does not last longer than 2 days or chat becomes null"
    ## does not account for chats lasting longer than 2 days
    type: number
    sql: CASE
      WHEN ${via_channel} = 'chat' AND DATEDIFF(day, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) < 1 THEN DATEDIFF(minute, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp)
      WHEN ${via_channel} = 'chat' AND DATEDIFF(day, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) = 1 THEN (DATEDIFF(minute, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) - 840)
      WHEN ${via_channel} = 'chat' AND DATEDIFF(day, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) = 2 THEN (DATEDIFF(minute, ${chat_start_time}::timestamp, ${chat_end_time}::timestamp) - 1740)
      ELSE NULL
      END
       ;;
  }

#   ## Assumes working  hours from 8am-6pm
#   dimension: first_reply_time_email {
#     label: "First Reply Time (Email)"
#     description: "Time to first reponse; assumes lag not last longer than 2 days or chat becomes null"
#     ## does not account for chats lasting longer than 2 days
#     type: number
#     sql: CASE
#       WHEN ${via_channel} = 'email' AND DATEDIFF(day, ${created_date}::timestamp, ${updated_date}::timestamp) < 1 THEN DATEDIFF(minute, ${created_time}::timestamp, ${updated_time}::timestamp)
#       WHEN ${via_channel} = 'email' AND DATEDIFF(day, ${created_date}::timestamp, ${updated_date}::timestamp) = 1 THEN (DATEDIFF(minute, ${created_time}::timestamp, ${updated_time}::timestamp) - 840)
#       WHEN ${via_channel} = 'email' AND DATEDIFF(day, ${created_date}::timestamp, ${updated_date}::timestamp) = 2 THEN (DATEDIFF(minute, ${created_time}::timestamp, ${updated_time}::timestamp) - 1740)
#       ELSE NULL
#       END
#        ;;
#   }

  dimension: first_reply_time_chat_tiers {
    type: tier
    tiers: [
      0,
      5,
      10,
      20,
      40,
      60,
      90,
      120,
      180,
      240,
      300,
      360,
      420
    ]
    sql: ${first_reply_time_chat} ;;
  }

  measure: average_chat_duration_minutes {
    description: "As accurate as possible to when the chat \"ended\" but can be thrown off if customers staying on between separate chats."
    type: average
    sql: ${chat_duration_minutes} ;;
  }

  measure: total_chat_duration_minutes {
    description: "As accurate as possible to when the chat \"ended\" but can be thrown off if customers staying on between separate chats."
    type: sum
    sql: ${chat_duration_minutes} ;;
  }

  measure: average_first_reply_time_chat {
    label: "Average First Reply Time Chat (Minutes)"
    type: average
    sql: ${first_reply_time_chat} ;;
  }

  measure: total_first_reply_time_chat {
    label: "Total First Reply Time Chat (Minutes)"
    description: "Does not make sense to aggregate response time over anything other than ticket number"
    type: sum
    sql: ${first_reply_time_chat} ;;
  }

  measure: count_chats {
    type: count

    filters: {
      field: is_chat
      value: "yes"
    }
  }

  measure: count_non_chats {
    label: "Count Non-Chats"
    type: count

    filters: {
      field: is_chat
      value: "No"
    }
  }
}
