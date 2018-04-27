connection: "fivetran_looker_blocks_demo"

include: "*_zendesk_block.view"
include: "*_zendesk_variables.view"
include: "*.dashboard"

explore: ticket {
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

  join: ticket_comment {
    type: left_outer
    sql_on: ${ticket.id} = ${ticket_comment.ticket_id} ;;
    relationship: one_to_many
  }

  join: commenter {
    sql_on: ${ticket_comment.user_id} = ${commenter.id} ;;
    relationship: many_to_one
  }

  join: ticket_assignee_facts {
    type: left_outer
    sql_on: ${ticket.assignee_id} = ${ticket_assignee_facts.assignee_id} ;;
    relationship: many_to_one
  }

  # metric queries

  join: ticket_history_facts {
    sql_on: ${ticket.id} = ${ticket_history_facts.ticket_id} ;;
    relationship: one_to_one
  }

  join: number_of_reopens {
    sql_on: ${ticket.id} = ${number_of_reopens.ticket_id} ;;
    relationship: one_to_one
  }
}
