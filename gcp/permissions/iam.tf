data "google_organization" "org" {
  domain = var.google_cloud_org_domain
}

resource "google_organization_iam_member" "ternary" {
  org_id = data.google_organization.org.org_id
  role   = google_organization_iam_custom_role.ternary_service_agent.name
  member = "serviceAccount:${var.ternary_service_account_email}"
}

resource "google_bigquery_iam_member" "ternary" {
  project_id = var.billing_export_project_id
  dataset_id = var.billing_export_dataset
  role       = "roles/bigquery.dataViewer"
}

resource "google_billing_account_iam_member" "ternary" {
  billing_account_id = var.billing_account_id
  role               = "roles/billing.viewer"
  member             = "serviceAccount:${var.ternary_service_account_email}"
}
