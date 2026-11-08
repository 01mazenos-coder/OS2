import type { Metadata } from 'next';
import './globals.css';
export const metadata: Metadata = { title: "b'ASK'a Tat | Menü", description: 'Kebap ve Lahmacun Salonu dijital menüsü' };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return <html lang="tr"><body>{children}</body></html>;
}
