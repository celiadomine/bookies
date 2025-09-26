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
git clone https://github.com/celiadomine/bookies.git

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

## Admin user erstellen
1. User normal über die Applikation registrieren
2. `bin/rails c`
3. `user = User.find_by(email_address: 'emailAdresseDesAdmins')`
4. `user.role = :admin`
5. `user.save`
6. `user.role`
7. `exit`
8. Server starten mit `bin/rails s`

