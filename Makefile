.PHONY: dc run test lint

dc:
	docker-compose up  --remove-orphans --build

dck8s:
	docker-compose build

run:
	go build -o app cmd/port-service/main.go && HTTP_ADDR=:8080 ./app

test:
	go test -race ./...

lint:
	golangci-lint run

