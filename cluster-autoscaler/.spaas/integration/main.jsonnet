local pipelines = import 'spaas/pipelines/integration.libsonnet';

local mainBranch = 'master';
local mainBranchRegex = '^%s$' % mainBranch;

[
  pipelines.newPipeline(
    'build-and-release',
    { env: 'dev', branch: mainBranchRegex, important: true },
    pipelines.tasks.serial([
      pipelines.tasks.manualApproval('approve-build-image'),
      pipelines.tasks.docker.build([{
        component: 'cluster-autoscaler',
        path: '.',
        buildContext: '.',
        platform: 'linux/amd64',
      }]),
      pipelines.tasks.manualApproval('approve-release'),
      pipelines.tasks.tagForRelease([{ name: 'cluster-autoscaler' }], pullRequest={ branch: 'tag/auto-tag-update', base: 'master', create: true, merge: false }),
    ]),
  ),
]
