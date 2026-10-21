# 🗑️ SDelete — Secure File Eraser / context menu

Lekki i wydajny skrypt wsadowy dla systemu Windows, który integruje bezpieczne, bezpowrotne kasowanie danych (zgodnie ze standardem *DoD 5220.22-M*) z menu kontekstowym pod prawym przyciskiem myszy. Narzędzie obsługuje pojedyncze pliki oraz całe katalogi, oferując czytelny interfejs konsoli z wizualnym paskiem postępu.

<p align="center">
  <img src="https://github.com/user-attachments/assets/c19fe60b-dc79-4603-ae12-d4cd158dc362" width="48%" alt="SDelete Oczekiwanie" />
  <img src="https://github.com/user-attachments/assets/3a6b4281-e56f-4790-979c-d687da664950" width="48%" alt="SDelete Wynik" />
</p>

---

## 📋 Wymagania

1. System operacyjny **Windows** (10/11).
2. Narzędzie **`sdelete64.exe`** z pakietu Sysinternals:
   * Pobierz z oficjalnej strony: [Microsoft Sysinternals SDelete](https://learn.microsoft.com/pl-pl/sysinternals/downloads/sdelete)
   * Alternatywne źródło pobierania: [MajorGeeks SDelete](https://www.majorgeeks.com/files/details/sdelete.html)
   * Zalecane: Skopiuj plik `sdelete64.exe` bezpośrednio do folderu `C:\Windows\System32\`.

---

## ⚙️ Instalacja i Odinstalowanie

* **Instalacja:** Uruchom plik `sd_context-install.reg`, aby dodać opcję **SDelete** do menu kontekstowego.
* **Odinstalowanie:** Uruchom plik `uninstall_sdelete.reg`, aby całkowicie usunąć opcję z rejestru.

---

## ✏️ Zmiana ścieżek i konfiguracja

### 1. Rejestr (`.reg`)
Jeśli przeniesiesz skrypt w inne miejsce, otwórz plik `.reg` w Notatniku i zaktualizuj ścieżki:

```registry
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\shell\SDelete]
@="SDelete"
"Icon"="cmd.exe"
[HKEY_CLASSES_ROOT\Directory\shell\SDelete\command]
@="\"C:\\TWOJA_SCIEZKA\\sdelete.bat\" \"%1\""

[HKEY_CLASSES_ROOT\*\\shell\SDelete]
@="SDelete"
"Icon"="cmd.exe"
[HKEY_CLASSES_ROOT\*\\shell\SDelete\command]
@="\"C:\\TWOJA_SCIEZKA\\sdelete.bat\" \"%1\""
```
💡 Uwaga: Używaj podwójnych ukośników (\\) w plikach .reg.

### 2. Skrypt (sdelete.bat)

Na samym początku skryptu możesz dostosować zmienne konfiguracyjne:
Fragment kodu
```registry
set "SDELETE_BIN=sdelete64.exe"
set "START_WAIT=10"
set "END_WAIT=10"
```
    SDELETE_BIN: Nazwa pliku w System32 lub pełna ścieżka do sdelete64.exe.
    START_WAIT / END_WAIT: Czas odliczania (w sekundach) przed i po skasowaniu.

🚀 Jak to działa?

Kliknij prawym przyciskiem myszy na plik lub folder i wybierz SDelete.
Masz 10 sekund na anulowanie operacji (CTRL+C lub zamknięcie okna).
Po upływie czasu skrypt trwale nadpisze i usunie wskazane pliki.

📄 Licencja

Projekt udostępniany jest na licencji MIT.
