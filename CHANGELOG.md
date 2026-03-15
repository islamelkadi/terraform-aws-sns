## [1.1.0](https://github.com/islamelkadi/terraform-aws-sns/compare/v1.0.3...v1.1.0) (2026-03-15)


### Features

* add manual triggering to release workflow ([8b9e7db](https://github.com/islamelkadi/terraform-aws-sns/commit/8b9e7dbb81c662347e666ffb3f29534b15c31f5c))

## [1.0.3](https://github.com/islamelkadi/terraform-aws-sns/compare/v1.0.2...v1.0.3) (2026-03-08)


### Bug Fixes

* update incorrect parameter ([67624f8](https://github.com/islamelkadi/terraform-aws-sns/commit/67624f82520cf30388501101bb40948598204e6e))


### Documentation

* add GitHub Actions workflow status badges ([89583ca](https://github.com/islamelkadi/terraform-aws-sns/commit/89583ca26ad81f40abf742673a3c36a2d5db576d))
* add security scan suppressions section to README ([a3aab46](https://github.com/islamelkadi/terraform-aws-sns/commit/a3aab466361940e138e53a23d6dcefbff13c9d43))

## [1.0.2](https://github.com/islamelkadi/terraform-aws-sns/compare/v1.0.1...v1.0.2) (2026-03-08)


### Bug Fixes

* add CKV_TF_1 suppression for external module metadata ([12b41bd](https://github.com/islamelkadi/terraform-aws-sns/commit/12b41bdf50aa2641eff5f537ad384822e94d4d26))
* add skip-path for .external_modules in Checkov config ([a217207](https://github.com/islamelkadi/terraform-aws-sns/commit/a217207aa7f32346f604a5f1398efd5192612a1e))
* address Checkov security findings ([69b27ad](https://github.com/islamelkadi/terraform-aws-sns/commit/69b27addaa7b6a7e37abe13aff83cdfba9e95710))
* correct .checkov.yaml format to use simple list instead of id/comment dict ([233361e](https://github.com/islamelkadi/terraform-aws-sns/commit/233361e0c64973faa5a8cf2e9099455f114650bc))
* remove skip-path from .checkov.yaml, rely on workflow-level skip_path ([8d56802](https://github.com/islamelkadi/terraform-aws-sns/commit/8d568029738a7dd37b81e76d644a042e3b8ae5aa))
* update workflow path reference to terraform-security.yaml ([97c600b](https://github.com/islamelkadi/terraform-aws-sns/commit/97c600b19cc53a0d51b1436a1f7098acb5e8ecf1))

## [1.0.1](https://github.com/islamelkadi/terraform-aws-sns/compare/v1.0.0...v1.0.1) (2026-03-08)


### Code Refactoring

* enhance examples with real infrastructure and improve code quality ([d51adb2](https://github.com/islamelkadi/terraform-aws-sns/commit/d51adb2af3cb8ea56249eedb116259fb0e7d0da9))

## 1.0.0 (2026-03-07)


### ⚠ BREAKING CHANGES

* First publish - SNS Terraform module

### Features

* First publish - SNS Terraform module ([66e4af6](https://github.com/islamelkadi/terraform-aws-sns/commit/66e4af6bdbcdc1ba915d5537f70faba1c76bd731))
