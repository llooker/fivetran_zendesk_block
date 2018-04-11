
view: user {
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
    label: "{% if  _view._name == 'assignee' %} {{'Assignee Name'}} {% else %} {{ 'Requester Name'}} {% endif %} "
    type: string
    sql: ${TABLE}.name ;;
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

# The submitter is the user who created a ticket.



# not relevant


# dimension: active {
#   type: yesno
#   sql: ${TABLE}.active ;;
# }
#
# dimension: two_factor_auth_enabled {
#   type: yesno
#   sql: ${TABLE}.two_factor_auth_enabled ;;
# }
#
# dimension: suspended {
#   type: yesno
#   sql: ${TABLE}.suspended ;;
# }
#
# dimension: remote_photo_url {
#   type: string
#   sql: ${TABLE}.remote_photo_url ;;
# }
#
# dimension_group: created {
#   type: time
#   timeframes: [
#     raw,
#     time,
#     date,
#     week,
#     month,
#     quarter,
#     year
#   ]
#   sql: ${TABLE}.created_at ;;
# }
#
# dimension: details {
#   type: string
#   sql: ${TABLE}.details ;;
# }
#
# dimension: external_id {
#   type: string
#   sql: ${TABLE}.external_id ;;
# }
#
# dimension: only_private_comments {
#   type: yesno
#   sql: ${TABLE}.only_private_comments ;;
# }
#
# dimension: shared {
#   type: yesno
#   sql: ${TABLE}.shared ;;
# }
#
# dimension: signature {
#   type: string
#   sql: ${TABLE}.signature ;;
# }
#
# dimension: ticket_restriction {
#   type: string
#   sql: ${TABLE}.ticket_restriction ;;
# }
#
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

# dimension_group: updated {
#   type: time
#   timeframes: [
#     raw,
#     time,
#     date,
#     week,
#     month,
#     quarter,
#     year
#   ]
#   sql: ${TABLE}.updated_at ;;
# }
#
# dimension: url {
#   type: string
#   sql: ${TABLE}.url ;;
# }
#
# dimension: verified {
#   type: yesno
#   sql: ${TABLE}.verified ;;
# }
