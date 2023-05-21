import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'stringToBase64'
})
export class StringToBase64Pipe implements PipeTransform {
  transform(value: string): string {
    return `data:image/png;base64,${value}`;
  }
}
