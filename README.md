# Bookies

Bookies ist eine soziale Buchverwaltungsplattform und eine Multiuser-Applikation, entwickelt im Rahmen der Projektarbeit für das Modul 223.

## 🚀 Erster Start

Um Bookies lokal zu starten, folgen Sie diesen Anweisungen.

### Voraussetzungen

- Ruby 3.4.5

- Ruby on Rails 8.0.2.1

- SQLite3

## 🛠️ Installation
1. Repository klonen:
```
git clone [Ihre Git-URL hier einfügen]
cd bookies
```

2. Abhängigkeiten installieren:
```
bundle install
```

3. Datenbank einrichten:
```
# Datenbank erstellen
rails db:create

# Schema migrieren
rails db:migrate

# Optional: Seed-Daten (Testnutzer, etc.) laden
rails db:seed
```

4. Tailwind CSS starten:
Stellen Sie sicher, dass der Tailwind CSS Watcher im Hintergrund läuft, um das Styling zu kompilieren:
```
bin/rails tailwindcss:watch
```

5. Server starten:
```
bin/rails server
```

6. Applikation aufrufen:
Öffnen Sie Ihren Browser unter `http://localhost:3000.`

