FROM rust



RUN groupadd appuser
RUN useradd -r -u 1001 -g appuser appuser 
USER appuser

COPY --chown=appuser:appuser design /design
COPY  --chown=appuser:appuser finiteelement /finiteelement
COPY  --chown=appuser:appuser finiteelement_macros /finiteelement_macros
COPY --chown=appuser:appuser appuser /appuser

RUN cd appuser && cargo build
