DB_URL=postgresql://mrkim:142536@139.59.100.0:5400/simple_bank?sslmode=disable

postgres:
	docker run --name postgres14 -p 5400:5432-e POSTGRES_USER=mrkim -e POSTGRES_PASS=142536 -d postgress:latest 

createdb:
	docker exec -it 4b5b050a892e createdb --username=mrkim --owner=mrkim simple_bank

dropdb:
	docker exec -it 4b5b050a892e dropdb simple_bank

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...


.PHONY: postgres createdb dropdb migrateup migratedown sqlc