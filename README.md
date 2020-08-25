# Slither Cloud Action

This action uses a Slither Cloud instance to create a [SARIF JSON](https://docs.github.com/en/github/finding-security-vulnerabilities-and-errors-in-your-code/uploading-a-sarif-file-to-github) file for upload to GitHub.

## Inputs

### `slither-cloud-uri`

**Required** The URI for the Slither Cloud instance.

### `truffle-version`

**Required** The version of Truffle to use to build the code. For example, `truffle@5.0.0`. To use the
latest version of Truffle, set this to `truffle`. This is also the default.

## Outputs

### `sarif-path`

The path to the generated SARIF JSON file.

## Example usage

```yaml
on: [push]

jobs:
  slither:
    runs-on: ubuntu-latest
    name: Run slither on the codebase
    steps:
    - name: Checkout repository
      uses: actions/checkout@v2
    - name: Run Slither
      id: slither
      uses: trailofbits/slither-cloud-action@v1
      with:
        slither-cloud-uri: ${SLITHER_CLOUD_URI_SECRET}
        truffle-version: 'truffle'
    - name: Upload SARIF file
      uses: github/codeql-action/upload-sarif@v1
      with:
        sarif_file: "${{ steps.slither.outputs.sarif-path }}"
```
