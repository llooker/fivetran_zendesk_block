connection: "fivetran_looker_blocks_demo"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: zendesk_block_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: zendesk_block_default_datagroup

explore: ticket {
  join: assignee {
    from: user
    sql_on: ${ticket.assignee_id} = ${assignee.id} ;;
    relationship: many_to_one
  }

  join: forum_topic {
    type: left_outer
    sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
    relationship: many_to_one
  }

  join: brand {
    type: left_outer
    sql_on: ${ticket.brand_id} = ${brand.id} ;;
    relationship: many_to_one
  }

  join: group {
    type: left_outer
    sql_on: ${ticket.group_id} = ${group.id} ;;
    relationship: many_to_one
  }

  join: organization {
    type: left_outer
    sql_on: ${ticket.organization_id} = ${organization.id} ;;
    relationship: many_to_one
  }
}


explore: brand {}

explore: fivetran_audit {}

explore: forum_topic {}

explore: group {}

explore: group_member {
  join: group {
    type: left_outer
    sql_on: ${group_member.group_id} = ${group.id} ;;
    relationship: many_to_one
  }

  join: user {
    type: left_outer
    sql_on: ${group_member.user_id} = ${user.id} ;;
    relationship: many_to_one
  }

  join: organization {
    type: left_outer
    sql_on: ${user.organization_id} = ${organization.id} ;;
    relationship: many_to_one
  }
}

explore: organization {
  join: group {
    type: left_outer
    sql_on: ${organization.group_id} = ${group.id} ;;
    relationship: many_to_one
  }
}

explore: organization_member {
  join: user {
    type: left_outer
    sql_on: ${organization_member.user_id} = ${user.id} ;;
    relationship: many_to_one
  }

  join: organization {
    type: left_outer
    sql_on: ${organization_member.organization_id} = ${organization.id} ;;
    relationship: many_to_one
  }

  join: group {
    type: left_outer
    sql_on: ${organization.group_id} = ${group.id} ;;
    relationship: many_to_one
  }
}

explore: organization_tag {
  join: organization {
    type: left_outer
    sql_on: ${organization_tag.organization_id} = ${organization.id} ;;
    relationship: many_to_one
  }

  join: group {
    type: left_outer
    sql_on: ${organization.group_id} = ${group.id} ;;
    relationship: many_to_one
  }
}



explore: ticket_comment {
  join: user {
    type: left_outer
    sql_on: ${ticket_comment.user_id} = ${user.id} ;;
    relationship: many_to_one
  }

  join: ticket {
    type: left_outer
    sql_on: ${ticket_comment.ticket_id} = ${ticket.id} ;;
    relationship: many_to_one
  }

  join: organization {
    type: left_outer
    sql_on: ${user.organization_id} = ${organization.id} ;;
    relationship: many_to_one
  }

  join: group {
    type: left_outer
    sql_on: ${organization.group_id} = ${group.id} ;;
    relationship: many_to_one
  }

  join: forum_topic {
    type: left_outer
    sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
    relationship: many_to_one
  }

  join: brand {
    type: left_outer
    sql_on: ${ticket.brand_id} = ${brand.id} ;;
    relationship: many_to_one
  }
}

explore: ticket_field_history {
  join: user {
    type: left_outer
    sql_on: ${ticket_field_history.user_id} = ${user.id} ;;
    relationship: many_to_one
  }

  join: ticket {
    type: left_outer
    sql_on: ${ticket_field_history.ticket_id} = ${ticket.id} ;;
    relationship: many_to_one
  }

  join: organization {
    type: left_outer
    sql_on: ${user.organization_id} = ${organization.id} ;;
    relationship: many_to_one
  }

  join: group {
    type: left_outer
    sql_on: ${organization.group_id} = ${group.id} ;;
    relationship: many_to_one
  }

  join: forum_topic {
    type: left_outer
    sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
    relationship: many_to_one
  }

  join: brand {
    type: left_outer
    sql_on: ${ticket.brand_id} = ${brand.id} ;;
    relationship: many_to_one
  }
}

explore: ticket_field_option {}

explore: ticket_tag {
  join: ticket {
    type: left_outer
    sql_on: ${ticket_tag.ticket_id} = ${ticket.id} ;;
    relationship: many_to_one
  }

  join: forum_topic {
    type: left_outer
    sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
    relationship: many_to_one
  }

  join: brand {
    type: left_outer
    sql_on: ${ticket.brand_id} = ${brand.id} ;;
    relationship: many_to_one
  }

  join: group {
    type: left_outer
    sql_on: ${ticket.group_id} = ${group.id} ;;
    relationship: many_to_one
  }

  join: organization {
    type: left_outer
    sql_on: ${ticket.organization_id} = ${organization.id} ;;
    relationship: many_to_one
  }
}

explore: ticket_tag_history {
  join: user {
    type: left_outer
    sql_on: ${ticket_tag_history.user_id} = ${user.id} ;;
    relationship: many_to_one
  }

  join: ticket {
    type: left_outer
    sql_on: ${ticket_tag_history.ticket_id} = ${ticket.id} ;;
    relationship: many_to_one
  }

  join: organization {
    type: left_outer
    sql_on: ${user.organization_id} = ${organization.id} ;;
    relationship: many_to_one
  }

  join: group {
    type: left_outer
    sql_on: ${organization.group_id} = ${group.id} ;;
    relationship: many_to_one
  }

  join: forum_topic {
    type: left_outer
    sql_on: ${ticket.forum_topic_id} = ${forum_topic.id} ;;
    relationship: many_to_one
  }

  join: brand {
    type: left_outer
    sql_on: ${ticket.brand_id} = ${brand.id} ;;
    relationship: many_to_one
  }
}

explore: user {
  join: organization {
    type: left_outer
    sql_on: ${user.organization_id} = ${organization.id} ;;
    relationship: many_to_one
  }

  join: group {
    type: left_outer
    sql_on: ${organization.group_id} = ${group.id} ;;
    relationship: many_to_one
  }
}
