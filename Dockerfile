# First Stage
FROM golang:1.22.5 as base

WORKDIR /app

#required as dependencies are stored in go.mod

COPY go.mod . 

RUN go mod download

COPY . .

RUN go build -o main .

# Final Stage - Distroless image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD [ "./main" ]
