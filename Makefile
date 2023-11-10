ifeq ($(POSTGRES_SETUP_STRING),)
	POSTGRES_SETUP_STRING := user=postgres password=postgres dbname=pg host=localhost port=5432 sslmode=disable
endif

INTERNAL_PKG_PATH=$(CURDIR)/internal/pkg
MIGRATION_FOLDER=$(CURDIR)/migrations

.PHONY: migration-create
migration-create:
	goose -dir "$(MIGRATION_FOLDER)" create "$(name)" sql

.PHONY: migration-up
migration-up:
	goose -dir "$(MIGRATION_FOLDER)" postgres "$(POSTGRES_SETUP_STRING)" up

.PHONY: migration-down
migration-down:
	goose -dir "$(MIGRATION_FOLDER)" postgres "$(POSTGRES_SETUP_STRING)" down

.PHONY: compose-up
compose-up:
	docker-compose up build

.PHONY: compose-rm
compose-rm:
	docker-compose down

