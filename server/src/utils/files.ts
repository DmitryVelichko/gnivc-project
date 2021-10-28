import * as fs from 'fs';
import { finished } from 'stream/promises';
import { ValidationError } from 'apollo-server-express';
import { Upload } from 'graphql-upload';

import File from '../database/models/file';

export async function saveFile(file: Upload, taskId: number): Promise<{ filename: string; size: number }> {
  const { createReadStream, filename } = await file.promise;
  const dir = `public/uploads/${taskId}`;

  if (fs.existsSync(`${dir}/${filename}`)) {
    throw new ValidationError(`File with name ${filename} already exist`);
  }

  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }

  const stream = createReadStream();
  const path = `${dir}/${filename}`;
  const out = require('fs').createWriteStream(path);

  stream.pipe(out);
  await finished(out);

  const { size } = require('fs').statSync(path);

  return File.create({ filename, size, taskId });
}

export function removeFile(file: File): void {
  const path = `public/uploads/${file.taskId}/${file.filename}`;
  fs.unlinkSync(path);
}
