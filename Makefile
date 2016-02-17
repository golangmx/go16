docker:
	docker build -t golangmx/go16 .

docker-run: docker
	(docker stop golangmx-go16 || exit 0) && \
	(docker rm golangmx-go16 || exit 0) && \
	docker run \
		-d \
		-p 127.0.0.1:3999:3999 \
		--name golangmx-go16 golangmx/go16

deploy:
	ssh deploy@play.golang.mx "mkdir -p ~/tmp/go16" && \
	rsync -av . deploy@play.golang.mx:~/tmp/go16 && \
	ssh deploy@play.golang.mx "cd ~/tmp/go16 && make docker-run"
