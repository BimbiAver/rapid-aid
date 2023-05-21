import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'utcToLocal'
})
export class UtcToLocalPipe implements PipeTransform {
  transform(value: string): string {
    // Convert utcDate to localDate
    const utcDate = new Date(value);
    const localDate = new Date(utcDate.getTime() + utcDate.getTimezoneOffset() * 60000);

    // Change the dateTime format
    const year = localDate.getFullYear();
    const month = ('0' + (localDate.getMonth() + 1)).slice(-2);
    const date = ('0' + localDate.getDate()).slice(-2);
    const hours = ('0' + localDate.getHours()).slice(-2);
    const minutes = ('0' + localDate.getMinutes()).slice(-2);
    const seconds = ('0' + localDate.getSeconds()).slice(-2);

    return `${year}-${month}-${date} ${hours}:${minutes}:${seconds}`;
  }
}
