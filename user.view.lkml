

view: user {
  sql_table_name: zendesk.user ;;
  extension: required

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
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
  }

  dimension: details {
    type: string
    sql: ${TABLE}.details ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: external_id {
    type: string
    sql: ${TABLE}.external_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: only_private_comments {
    type: yesno
    sql: ${TABLE}.only_private_comments ;;
  }

  dimension: organization_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.organization_id ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: remote_photo_url {
    type: string
    sql: ${TABLE}.remote_photo_url ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  dimension: shared {
    type: yesno
    sql: ${TABLE}.shared ;;
  }

  dimension: signature {
    type: string
    sql: ${TABLE}.signature ;;
  }

  dimension: ticket_restriction {
    type: string
    sql: ${TABLE}.ticket_restriction ;;
  }

  dimension: time_zone {
    type: string
    sql: ${TABLE}.time_zone ;;
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
  }

  dimension: url {
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: verified {
    type: yesno
    sql: ${TABLE}.verified ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
}
view: assignee {
  extends: [user]

  dimension: chat_only {
    type: yesno
    sql: ${TABLE}.chat_only ;;
  }

  dimension: custom_role_id {
    type: number
    sql: ${TABLE}.custom_role_id ;;
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

  dimension: two_factor_auth_enabled {
    type: yesno
    sql: ${TABLE}.two_factor_auth_enabled ;;
  }

  dimension: suspended {
    type: yesno
    sql: ${TABLE}.suspended ;;
  }

}

# The submitter is the user who created a ticket.



# not relevant


#   dimension: alias {
#     type: string
#     sql: ${TABLE}.alias ;;
#   }
#
#   dimension: authenticity_token {
#     type: string
#     sql: ${TABLE}.authenticity_token ;;
#   }
#
#   dimension: locale_id {
#     type: number
#     sql: ${TABLE}.locale_id ;;
#   }
