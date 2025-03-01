param name string

resource siteConfig 'Microsoft.Web/sites/config@2021-02-01' = {
  name: name
}
