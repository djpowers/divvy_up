# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Added
- Allow specifying item price via hash attribute
- Allow specifying quantity of item via hash attribute

## [0.1.2] - 2015-07-09
### Fixed
- Resolve potential infinite loop in `#split` occurring when no valid solution is possible using "permute" technique

## [0.1.1] - 2015-07-05
### Fixed
- Resolve error occurring in `#split` method for certain list and group number combinations

## [0.1.0] - 2015-07-04
### Changed
- Process list through two additional algorithms to handle edge cases and ensure optimal results when using `#split` method

## 0.0.1 - 2015-03-09
- Initial release

[unreleased]: https://github.com/djpowers/divvy_up/compare/v0.1.2...HEAD
[0.1.2]: https://github.com/djpowers/divvy_up/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/djpowers/divvy_up/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/djpowers/divvy_up/compare/v0.0.1...v0.1.0
