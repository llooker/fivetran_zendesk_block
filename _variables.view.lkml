view: _variables {

# Schema Name for the Zendesk data - Fivetran default is 'zendesk'
# Must do a find/replace for this variable.
  dimension: _SCHEMA_NAME {
    type: string
    hidden: yes
    sql: 'zendesk' ;;
  }

# Name of your company Zendesk instance (i.e. looker.zendesk.com)
# Update sql value below
  dimension: _ZENDESK_INSTANCE_DOMAIN {
    type: string
    hidden: yes
    sql: 'looker' ;;
  }

# Name of your company Looker instance (i.e. company_name.looker.com)
# Update sql value below
  dimension: _LOOKER_INSTANCE_DOMAIN {
    type: string
    hidden: yes
    sql: 'fivetrandemo' ;;
  }

# Once you convert the Dashboard from LookML, the ID of the Zendesk Ticket Detail Dashboard
# Update sql value below
  dimension: _ZENDESK_TICKET_DETAIL_DASHBOARD_ID {
    type: number
    hidden: yes
    sql: 6 ;;
  }

# Once you convert the Dashboard from LookML, the ID of the Zendesk Ticket Detail Dashboard
# Update sql value below
  dimension: _ZENDESK_AGENT_PERFORMANCE_DASHBOARD_ID {
    type: number
    hidden: yes
    sql: 8 ;;
  }

# Name of your organization ID in Zendesk instance
# Update sql value below
  dimension: _INTERNAL_ORGANIZATION_ID {
    type: number
    hidden: yes
    sql: 27173710 ;;
  }

# Ticket Status Names in Zendesk
# These are unlikely to be different for your organization, but are here in case Zendesk changes any language.
  dimension: _TICKET_STATUS_CLOSED {
    type: string
    hidden: yes
    sql: 'closed' ;;
  }

  dimension: _TICKET_STATUS_DELETED {
    type: string
    hidden: yes
    sql: 'deleted' ;;
  }

  dimension: _TICKET_STATUS_NEW {
    type: string
    hidden: yes
    sql: 'new' ;;
  }

  dimension: _TICKET_STATUS_OPEN {
    type: string
    hidden: yes
    sql: 'open' ;;
  }

  dimension: _TICKET_STATUS_HOLD {
    type: string
    hidden: yes
    sql: 'hold' ;;
  }

  dimension: _TICKET_STATUS_SOLVED {
    type: string
    hidden: yes
    sql: 'solved' ;;
  }

# ----- Dialect Variables -----
# Used for easy block implementation when using dialects other than Big Query.

  dimension: _CURRENT_DATE {
    type: date
    hidden: yes
    sql: CURRENT_DATE() ;;
  }

}
