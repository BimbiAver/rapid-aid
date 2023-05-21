import { StringToBase64Pipe } from './string-to-base64.pipe';

describe('StringToBase64Pipe', () => {
  it('create an instance', () => {
    const pipe = new StringToBase64Pipe();
    expect(pipe).toBeTruthy();
  });
});
