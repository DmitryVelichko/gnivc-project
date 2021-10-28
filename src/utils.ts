export default function formatDateToDB(date: string): string {
  const [day, month, year] = date.split('.');
  return `${year}-${month}-${day}`;
}

export function formatDateToRU(date: string): string {
  return new Date(date).toLocaleDateString('ru-RU');
}

export function formatNumber(int: number): string {
  return new Intl.NumberFormat('ru-RU').format(int);
}

export function pluralize(num: number, titles: string[]): string {
  const cases = [2, 0, 1, 1, 1, 2];
  return titles[(num % 100 > 4 && num % 100 < 20) ? 2 : cases[(num % 10 < 5) ? num % 10 : 5]];
}
