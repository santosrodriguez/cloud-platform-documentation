resource "azurerm_search_service" "this" {
  name                          = local.names.search
  resource_group_name           = var.resource_group_name
  location                      = local.location
  sku                           = var.search_sku
  replica_count                 = var.search_replica_count
  partition_count               = var.search_partition_count
  semantic_search_sku           = var.enable_semantic_search ? var.semantic_search_sku : null
  local_authentication_enabled  = false
  public_network_access_enabled = false
  network_rule_bypass_option    = "None"
  tags                          = local.tags

  identity {
    type = "SystemAssigned"
  }
}

resource "azapi_data_plane_resource" "wiki_index" {
  count = var.create_search_index ? 1 : 0

  type      = "Microsoft.Search/searchServices/indexes@2024-07-01"
  parent_id = "${azurerm_search_service.this.name}.search.windows.net"
  name      = var.search_index_name

  body = merge(
    {
      fields = [
        {
          name       = "id"
          type       = "Edm.String"
          key        = true
          searchable = false
          filterable = true
          sortable   = true
        },
        {
          name       = "title"
          type       = "Edm.String"
          searchable = true
          filterable = true
          sortable   = true
        },
        {
          name       = "content"
          type       = "Edm.String"
          searchable = true
          analyzer   = "en.lucene"
        },
        {
          name       = "url"
          type       = "Edm.String"
          searchable = false
          filterable = true
        },
        {
          name       = "path"
          type       = "Edm.String"
          searchable = true
          filterable = true
        },
        {
          name       = "section"
          type       = "Edm.String"
          searchable = true
          filterable = true
          facetable  = true
        },
        {
          name       = "content_hash"
          type       = "Edm.String"
          searchable = false
          filterable = true
        },
        {
          name       = "updated_at"
          type       = "Edm.DateTimeOffset"
          searchable = false
          filterable = true
          sortable   = true
        },
        {
          name       = "access_groups"
          type       = "Collection(Edm.String)"
          searchable = false
          filterable = true
        },
        {
          name                    = "content_vector"
          type                    = "Collection(Edm.Single)"
          searchable              = true
          vectorSearchDimensions  = var.embedding_dimensions
          vectorSearchProfileName = "wiki-vector-profile"
        },
      ]
      vectorSearch = {
        algorithms = [
          {
            name = "wiki-hnsw"
            kind = "hnsw"
            hnswParameters = {
              metric         = "cosine"
              m              = 4
              efConstruction = 400
              efSearch       = 500
            }
          },
        ]
        profiles = [
          {
            name      = "wiki-vector-profile"
            algorithm = "wiki-hnsw"
          },
        ]
      }
    },
    var.enable_semantic_search ? {
      semantic = {
        defaultConfiguration = "wiki-semantic"
        configurations = [
          {
            name = "wiki-semantic"
            prioritizedFields = {
              titleField = {
                fieldName = "title"
              }
              prioritizedContentFields = [
                {
                  fieldName = "content"
                },
              ]
              prioritizedKeywordsFields = [
                {
                  fieldName = "section"
                },
              ]
            }
          },
        ]
      }
    } : {},
  )

  depends_on = [time_sleep.data_plane_rbac]
}
