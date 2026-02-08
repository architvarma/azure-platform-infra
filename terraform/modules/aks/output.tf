output "cluster_name" {
  value = azurerm_kubernetes_cluster.this.name
}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}