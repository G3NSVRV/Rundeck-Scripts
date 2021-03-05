ARG IMAGE
FROM ${IMAGE}

ARG RD_STORAGE_ENDPOINT
ARG RD_STORAGE_BUCKET
ARG MINIO_PORT
ARG MINIO_USER
ARG MINIO_PASS

ENTRYPOINT /bin/bash -c "mc config host add --api s3v4 minio ${RD_STORAGE_ENDPOINT}:${MINIO_PORT} ${MINIO_USER} ${MINIO_PASS}; mc rb --force minio/${RD_STORAGE_BUCKET}; mc mb minio/${RD_STORAGE_BUCKET}; mc policy set public minio/${RD_STORAGE_BUCKET}; curl -s -D - ${RD_STORAGE_ENDPOINT} | grep  X-Amz-Bucket-Region | sed 's/X-Amz-Bucket-Region/Region/g'"
