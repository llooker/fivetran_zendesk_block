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

# dimension: is_active {
#   type: yesno
#   sql: ${TABLE}.active ;;
# }
#
# dimension: is_default {
#   type: yesno
#   sql: ${TABLE}.`default` ;;
# }
#
# dimension: subdomain {
#   type: string
#   sql: ${TABLE}.subdomain ;;
# }
#
# dimension: url {
#   type: string
#   sql: ${TABLE}.url ;;
# }
#
# dimension: brand_url {
#   type: string
#   sql: ${TABLE}.brand_url ;;
# }
