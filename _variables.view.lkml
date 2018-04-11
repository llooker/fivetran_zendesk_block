view: _variables {

  dimension: _ZENDESK_INSTANCE_DOMAIN {
    type: string
    hidden: yes
    sql: 'looker' ;;
  }

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

}
