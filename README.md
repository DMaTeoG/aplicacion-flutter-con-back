# 📚 Sistema de Reviews (Flutter + Supabase)

Una aplicación simple en **Flutter** con backend en **Supabase** que permite a los usuarios (sin login) calificar libros, películas o productos con ⭐ y dejar comentarios.  
El promedio de calificaciones se calcula automáticamente y se muestra junto con la cantidad total de reseñas.

---

## 🚀 Tecnologías utilizadas
- [Flutter](https://flutter.dev/) – Framework para la app móvil/web  
- [GetX](https://pub.dev/packages/get) – Manejo de estado y navegación  
- [Supabase](https://supabase.com/) – Backend (Postgres + Auth + Storage)  
- [shared_preferences](https://pub.dev/packages/shared_preferences) – Guardar `device_id` local  
- [uuid](https://pub.dev/packages/uuid) – Generar identificador único por dispositivo  

---

## 📂 Estructura de carpetas
```
lib/
│
├── controllers/        # Controladores con GetX (estado, lógica)
│   ├── item_controller.dart
│   └── review_controller.dart
│
├── screens/            # Pantallas principales
│   ├── item_list_screen.dart
│   └── item_detail_screen.dart
│
├── utils/              # Utilidades (ej: generar device_id)
│   └── device_id.dart
│
└── main.dart           # Punto de entrada, inicializa Supabase
```

---

## 🗄️ Esquema de base de datos (Supabase)

### Tabla `items`
```sql
create table if not exists items (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  image_url text,
  created_at timestamp default now()
);
```

### Tabla `reviews`
```sql
create table if not exists reviews (
  id uuid primary key default gen_random_uuid(),
  device_id text not null,
  item_id uuid references items(id) on delete cascade,
  rating int check (rating between 1 and 5),
  comment text,
  created_at timestamp default now(),
  unique(device_id, item_id)
);
```

### Vista `item_with_rating`
```sql
create or replace view item_with_rating as
select 
  i.id,
  i.title,
  i.description,
  i.image_url,
  coalesce(avg(r.rating), 0) as avg_rating,
  count(r.id) as total_reviews
from items i
left join reviews r on r.item_id = i.id
group by i.id;
```

---

## 📖 Funcionalidades
- 📌 Listar items con su calificación promedio.  
- ⭐ Dejar una reseña con estrellas (1–5) y comentario.  
- 📊 Calcular y mostrar el promedio en tiempo real.  
- 📱 Identificación de usuarios por `device_id` (no requiere login).  
- 🎨 Interfaz moderna con **GetX + Material Design**.  

---

## 🔧 Configuración del proyecto

### 1. Clonar el repo
```bash
git clone https://github.com/tuusuario/reviews_app.git
cd reviews_app
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Configurar Supabase
En `main.dart`, reemplaza con tus credenciales:  

```dart
await Supabase.initialize(
  url: 'https://TU-PROJECT-ID.supabase.co',
  anonKey: 'TU-ANON-KEY',
);
```

Puedes obtener estos valores en:  
⚙️ **Settings → API** dentro de tu proyecto de Supabase.

### 4. Ejecutar
En móvil:
```bash
flutter run
```

En web:
```bash
flutter run -d chrome
```

---

## 🎯 Próximas mejoras
- 📷 Permitir fotos en los reviews (usando Supabase Storage).  
- ❤️ Likes a las reseñas de otros usuarios.  
- 🔒 Sistema de login opcional (Google, Email, etc.).  
- 🔎 Filtros por categoría o rating.  

---

## 📜 Licencia
Este proyecto es de código abierto bajo la licencia MIT.  
