#!/bin/bash
# 自动切除所有PDF页面的白边
for FILE in ./*.pdf; do
  pdfcrop "${FILE}" "${FILE}"
done
