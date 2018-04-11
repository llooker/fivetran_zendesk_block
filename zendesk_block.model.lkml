connection: "fivetran_looker_blocks_demo"

include: "*.view"
include: "*.dashboard"

datagroup: zendesk_block_default_datagroup {
  max_cache_age: "1 hour"
}
persist_with: zendesk_block_default_datagroup

explore: ticket {
#   from: chat_fields
  join: assignee {
    sql_on: ${ticket.assignee_id} = ${assignee.id} ;;
    relationship: many_to_one
  }

  join: requester {
    sql_on: ${ticket.requester_id} = ${requester.id} ;;
    relationship: many_to_one
  }

  join: group_member {
    sql_on: ${assignee.id} = ${group_member.user_id} ;;
    relationship: many_to_one
  }

  join: group {
    sql_on: ${group_member.group_id} = ${group.id} ;;
    relationship: many_to_one
  }

  join: organization_member {
    sql_on: ${requester.id} = ${organization_member.user_id} ;;
    relationship: many_to_one
  }

  join: organization {
    sql_on: ${organization_member.organization_id} = ${organization.id} ;;
    relationship: many_to_one
  }

  join: brand {
    type: left_outer
    sql_on: ${ticket.brand_id} = ${brand.id} ;;
    relationship: many_to_one
  }

  # metric queries

  join: ticket_history_facts {
    sql_on: ${ticket.id} = ${ticket_history_facts.ticket_id} ;;
    relationship: one_to_one
  }
#   join: last_updated_by_assignee {
#     view_label: "Ticket"
#     sql_on: ${ticket.id} = ${last_updated_by_assignee.ticket_id} ;;
#     relationship: one_to_one
#   }
#
#   join: last_updated_by_requester {
#     view_label: "Ticket"
#     sql_on: ${ticket.id} = ${last_updated_by_requester.ticket_id} ;;
#     relationship: one_to_one
#   }
#
#   join: number_of_assignees {
#     view_label: "Ticket"
#     sql_on: ${ticket.id} = ${number_of_assignees.ticket_id} ;;
#     relationship: one_to_one
#   }

  join: number_of_reopens {
    sql_on: ${ticket.id} = ${number_of_reopens.ticket_id} ;;
    relationship: one_to_one
  }

#   join: ticket_assignee_facts {
#     sql_on: ${ticket.assignee_id} = ${ticket_assignee_facts.assignee_id} ;;
#     relationship: many_to_one
#   }

#   join: ticket_history {
#     ## a view_label parameter changes the name of the view in the Explore section
#     view_label: "Tickets"
#     sql_on: ${ticket_history.ticket_id} = ${ticket.id} ;;
#     ## use one_to_one to force a fanout on tickets
#     relationship: one_to_many
#     fields: [ticket_id, new_value, total_agent_touches]
#   }
}

#
# explore: brand {}
#
# explore: fivetran_audit {}
#
# explore: forum_topic {}
#
# explore: group {}
#
# explore: group_member {
#   join: group {
#     type: left_outer
#     sql_on: ${group_member.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
#
#   join: user {
#     type: left_outer
#     sql_on: ${group_member.user_id} = ${user.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${user.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: organization {
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: organization_member {
#   join: user {
#     type: left_outer
#     sql_on: ${organization_member.user_id} = ${user.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${organization_member.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
# }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
# }
#
#
#
# explore: ticket_comment {
#   join: user {
#     type: left_outer
#     sql_on: ${ticket_comment.user_id} = ${user.id} ;;
#     relationship: many_to_one
#   }
#
#   join: ticket {
#     type: left_outer
#     sql_on: ${ticket_comment.ticket_id} = ${ticket.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${user.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
#
#   join: forum_topic {
#     type: left_outer
#     sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
#     relationship: many_to_one
#   }
#
#   join: brand {
#     type: left_outer
#     sql_on: ${ticket.brand_id} = ${brand.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: ticket_field_history {
#   join: user {
#     type: left_outer
#     sql_on: ${ticket_field_history.user_id} = ${user.id} ;;
#     relationship: many_to_one
#   }
#
#   join: ticket {
#     type: left_outer
#     sql_on: ${ticket_field_history.ticket_id} = ${ticket.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${user.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
#
#   join: forum_topic {
#     type: left_outer
#     sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
#     relationship: many_to_one
#   }
#
#   join: brand {
#     type: left_outer
#     sql_on: ${ticket.brand_id} = ${brand.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: ticket_field_option {}
#
# explore: ticket_tag {
#   join: ticket {
#     type: left_outer
#     sql_on: ${ticket_tag.ticket_id} = ${ticket.id} ;;
#     relationship: many_to_one
#   }
#
#   join: forum_topic {
#     type: left_outer
#     sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
#     relationship: many_to_one
#   }
#
#   join: brand {
#     type: left_outer
#     sql_on: ${ticket.brand_id} = ${brand.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${ticket.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${ticket.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: ticket_tag_history {
#   join: user {
#     type: left_outer
#     sql_on: ${ticket_tag_history.user_id} = ${user.id} ;;
#     relationship: many_to_one
#   }
#
#   join: ticket {
#     type: left_outer
#     sql_on: ${ticket_tag_history.ticket_id} = ${ticket.id} ;;
#     relationship: many_to_one
#   }
#
#   join: organization {
#     type: left_outer
#     sql_on: ${user.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
#
#   join: forum_topic {
#     type: left_outer
#     sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
#     relationship: many_to_one
#   }
#
#   join: brand {
#     type: left_outer
#     sql_on: ${ticket.brand_id} = ${brand.id} ;;
#     relationship: many_to_one
#   }
# }
#
# explore: user {
#   join: organization {
#     type: left_outer
#     sql_on: ${user.organization_id} = ${organization.id} ;;
#     relationship: many_to_one
#   }
#
#   join: group {
#     type: left_outer
#     sql_on: ${organization.group_id} = ${group.id} ;;
#     relationship: many_to_one
#   }
# }
