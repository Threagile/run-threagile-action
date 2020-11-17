# GitHub action to run Threagile

This action runs Threagile as part of a GitHub workflow.

## Inputs

### `model-file`

**Required** The name of the Threagile model input file. Default `"threagile.yaml"`.

## Outputs

The output is handled as files via artifacts.

## Example usage

on:
  push:
    paths:
      - 'threagile.yaml' # useful to filter this job to execute only when the threat model changes

jobs:
  threagile_job:
    runs-on: ubuntu-latest
    name: Threat Model Analysis
    steps:
      
      # Checkout the repo
      - name: Checkout Workspace
        uses: actions/checkout@v2
     
      # Run Threagile
      - name: Run Threagile
        id: threagile
        uses: threagile/run-threagile-action@v1
        with:
          model-file: 'threagile.yaml'
     
      # Archive resulting files as artifacts
      - name: Archive Results
        uses: actions/upload-artifact@v2
        with:
          name: threagile-report
          path: threagile/output
     
      # Optional step to link from repo's README.md if you want. This can also be committed to a separate branch if desired.
      - name: Commit & Push DFD Diagram 
        run: |
          git config --local user.email "threagile@example.com" # customize as desired
          git config --local user.name "Threagile" # customize as desired
          git add threagile/output/data-flow-diagram.png
          git add threagile/output/report.pdf
          git commit -m "Update threat model report and data-flow diagram by Threagile" # customize as desired
          git push
