# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), 

and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

# Unreleased

## Changed

- Nothing changed yet.

## Removed

- Nothing removed  yet.
## 0.1.4 - 2023-02-28

## Added

- When instantiating the Pixclass you can add an optional parameter: 'ambiente', which will define what the request environment will be the parameter can receive: 
Ambiente.homologacao or Ambiente.producaoby default when instantiating the parameter production will be defined

## Fixed
- Fixed the list received by the request returned as an increasing list, now by default the list will be descending from the most recent transaction date to the last one received
- Fixed typo in README.md
