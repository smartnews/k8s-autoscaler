local pipelines = import 'spaas/pipelines/integration.libsonnet';

pipelines.newPipelines(
  'ops-spaas',
  import './integration/main.jsonnet',
)
