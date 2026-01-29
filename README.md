# ✅ To Do App with Cubit & Bloc (Flutter Flavors)

A Flutter To-Do application built to **compare and demonstrate state management using Cubit and Bloc** within the same project, using **Flavors** to switch between implementations.

---

## 📌 Project Overview

This project is a simple yet powerful **To-Do App** that allows users to:
- Add tasks
- Mark tasks as completed
- Manage tasks efficiently

The main goal of this project is to **show the architectural and logical differences between Cubit and Bloc** by providing two separate app flavors:
- **Cubit Version**
- **Bloc Version**

Each flavor runs the same UI but with a different state management approach.

---

## 🎯 Project Goals

- Practice and understand **Flutter Bloc & Cubit**
- Compare **Cubit vs Bloc** in real use cases
- Learn how to use **Flutter Flavors**
- Build a clean, scalable Flutter architecture
- Create a strong portfolio project

---

## 🧠 State Management Approaches

### 🔹 Cubit Version
- Simpler logic
- Less boilerplate
- Direct state emission
- Ideal for small to medium apps

### 🔹 Bloc Version
- Event-driven architecture
- Clear separation of concerns
- More scalable for large applications
- Better control over business logic

---

## 🧪 Flavors Used

The app contains **two flavors**:

| Flavor Name | State Management |
|-------|-----------------|------------|
| Cubit | `main_cubit.dart` |
| Bloc | `main_bloc.dart` |

---
### 🔹 Hydrated Bloc
- Hydrated Bloc State Persistence & Restoration
- Hydrated Bloc automatically saves the Bloc/Cubit state to local storage. 
- It allows state restoration upon application restart without any additional code.

---

## 📦 Packages Used

```yaml
flutter_bloc: ^9.1.1
equatable: ^2.0.8
uuid: ^4.5.2
hydrated_bloc: ^10.1.1
path_provider: ^2.1.5