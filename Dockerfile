FROM debian:bullseye-slim
WORKDIR /app
COPY latex_deps.sh .
RUN bash ./latex_deps.sh
RUN  rm -rf /var/lib/apt/lists/*; \
    apt clean && apt autoremove; \
    rm -rf /etc/apt/sources.list;
CMD pdflatex *.tex
