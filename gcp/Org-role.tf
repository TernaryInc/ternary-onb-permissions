resource "google_organization_iam_custom_role" "ternary_service_agent" {
  role_id     = "TernaryCMPServiceAgent"
  org_id      = data.google_organization.org.org_id # or the org number in quotes "123456789"
  title       = "Ternary CMP Service Agent"
  description = "Permissions for Ternary to access your cloud for cost insights"
  permissions = [
    "bigquery.bireservations.get", # BigQuery Visibility Feature
    "bigquery.capacityCommitments.get", # BigQuery Visibility Feature
    "bigquery.capacityCommitments.list", # BigQuery Visibility Feature
    "bigquery.jobs.get", # BigQuery Visibility Feature
    "bigquery.jobs.list", # BigQuery Visibility Feature
    "bigquery.jobs.listAll", # BigQuery Visibility Feature
    "bigquery.reservationAssignments.list", # BigQuery Visibility Feature
    "bigquery.reservationAssignments.search", # BigQuery Visibility Feature
    "bigquery.reservations.get", # BigQuery Visibility Feature
    "bigquery.reservations.list", # BigQuery Visibility Feature
    "cloudasset.assets.exportResource", # Find projects with a specific asset type (ex. CUD, Compute Instance, etc.)
    "compute.commitments.list", # GCE CUD Planning feature, CUD expiration alerts
    "monitoring.timeSeries.list", # Gather metrics, used in multiple features
    "recommender.bigqueryCapacityCommitmentsRecommendations.get", # [Future] BigQuery Slot Reservation Recommendations
    "recommender.bigqueryCapacityCommitmentsRecommendations.list", # [Future] BigQuery Slot Reservation Recommendations
    "recommender.bigqueryCapacityCommitmentsInsights.get", # [Future] BigQuery Slot Reservation Recommendations
    "recommender.bigqueryCapacityCommitmentsInsights.list", # [Future] BigQuery Slot Reservation Recommendations
    "recommender.cloudsqlIdleInstanceRecommendations.get", # [Future] Cloud SQL Idle Resource Recommendations
    "recommender.cloudsqlIdleInstanceRecommendations.list", # [Future] Cloud SQL Idle Resource Recommendations
    "recommender.cloudsqlInstanceOutOfDiskRecommendations.get",  # [Future] Cloud SQL Disk Recommendations
    "recommender.cloudsqlInstanceOutOfDiskRecommendations.list",  # [Future] Cloud SQL Disk Recommendations
    "recommender.cloudsqlOverprovisionedInstanceRecommendations.get", # [Future] Cloud SQL Rightsizing Recommendations
    "recommender.cloudsqlOverprovisionedInstanceRecommendations.list", # [Future] Cloud SQL Rightsizing Recommendations
    "recommender.computeAddressIdleResourceInsights.get", # [Future] Compute Engine Idle IP Address Recommendations
    "recommender.computeAddressIdleResourceInsights.list", # [Future] Compute Engine Idle IP Address Recommendations
    "recommender.computeAddressIdleResourceRecommendations.get", # [Future] Compute Engine Idle IP Address Recommendations
    "recommender.computeAddressIdleResourceRecommendations.list", # [Future] Compute Engine Idle IP Address Recommendations
    "recommender.computeDiskIdleResourceInsights.get",  # Compute Engine Idle Disk Recommendations
    "recommender.computeDiskIdleResourceInsights.list", # Compute Engine Idle Disk Recommendations
    "recommender.computeDiskIdleResourceRecommendations.get", # Compute Engine Idle Disk Recommendations
    "recommender.computeDiskIdleResourceRecommendations.list", # Compute Engine Idle Disk Recommendations
    "recommender.computeImageIdleResourceInsights.get", # [Future] Compute Engine Unused Custom Image Recommendation
    "recommender.computeImageIdleResourceInsights.list", # [Future] Compute Engine Unused Custom Image Recommendation
    "recommender.computeImageIdleResourceRecommendations.get", # [Future] Compute Engine Unused Custom Image Recommendation
    "recommender.computeImageIdleResourceRecommendations.list", # [Future] Compute Engine Unused Custom Image Recommendation
    "recommender.computeInstanceIdleResourceRecommendations.get", # Compute Engine Idle Resource Recommendations
    "recommender.computeInstanceIdleResourceRecommendations.list", # Compute Engine Idle Resource Recommendations
    "recommender.computeInstanceMachineTypeRecommendations.get", # Compute Engine Instance Rightsizing Recommendations
    "recommender.computeInstanceMachineTypeRecommendations.list", # Compute Engine Instance Rightsizing Recommendations
    "recommender.computeInstanceGroupManagerMachineTypeRecommendations.get", # Compute Engine Instance Group Rightsizing Recommendations
    "recommender.computeInstanceGroupManagerMachineTypeRecommendations.list", # Compute Engine Instance Group Rightsizing Recommendations
    "recommender.resourcemanagerProjectUtilizationRecommendations.get", # [Future] Unattended Project Recommendations
    "recommender.resourcemanagerProjectUtilizationRecommendations.list", # [Future] Unattended Project Recommendations
    "recommender.spendBasedCommitmentRecommendations.get", # [Future] Spend Based Commitment Recommendations
    "recommender.spendBasedCommitmentRecommendations.list", # [Future] Spend Based Commitment Recommendations
    "recommender.usageCommitmentRecommendations.get", # [Future] Usage Based Commitment Recommendations
    "recommender.usageCommitmentRecommendations.list", # [Future] Usage Based Commitment Recommendations
    "recommender.networkAnalyzerIpAddressInsights.get", # Unused Static IP Address Recommendations
    "recommender.networkAnalyzerIpAddressInsights.list", # Unused Static IP Address Recommendations
    "resourcemanager.folders.get", # Allows Ternary to traverse GCP Organizations and find projects
    "resourcemanager.folders.list", # Allows Ternary to traverse GCP Organizations and find projects
    "resourcemanager.organizations.get", # Allows Ternary to traverse GCP Organizations and find projects
    "resourcemanager.projects.get", # List Projects, used in multiple features
    "resourcemanager.projects.list", # List Projects, used in multiple features
  ]
}
