# 🗓️ calendrier

**calendrier** is an iOS-based note-taking application using SwiftData (for data persistence), providing users with a clean and simple (yet cute!) interface for managing text and drawing notes. I designed this to be simple and easy to use, while still maintaining functionality. You can view, delete, filter and modify notes as needed. 

As someone who loves to delve into UX/UI solutions, I designed this app to provide a simple, yet aesthetically pleasing UI solution, with clean user flows. 

(MVP, basic demo video)[https://youtu.be/ZHfvFoAdSMk]

<p align="center">
<img width="251" height="527" alt="image" src="https://github.com/user-attachments/assets/6e7661e8-7664-444c-9c96-8b1e2b3699b9" />
<img width="251" height="527" alt="image" src="https://github.com/user-attachments/assets/67102d19-c07f-4d59-ae61-18ad907e2c71" />
<img width="251" height="527" alt="image" src="https://github.com/user-attachments/assets/1d33acc4-92d0-4eb8-a7ee-cde518f4fe78" />
</p>


---

## ‼️ features

* **take your notes!**: Create standard notes, or hand-drawn notes; integrated using Apple's PencilKit framework. To edit an existing note, simply tap on it.
* **filters & sorting**: Sort and filter notes if needed.
* **delete notes**: Pretty straightforward, delete any notes with a clean and intuitive UI.
* **persistent storage**: Notes are stored using **SwiftData**, ensuring data persistence. Note, data persistence is local to your device.
* **custom styling**: I utilized my own styling, having a modern, yet fun UI using custom colours and subtle animations
* **Rive integration**: Integrated Rive, an interactive design animation tool, for animations in backgrounds

_In the future, I hope to add image support (i.e. drop images from gallery), and more extensive filtering with your own tags._

---

## ⁉️ architecture

* **MVVM Pattern**:

  * `HomeVM` — Handles home page state, filter selection, and note navigation.
  * `NotePageVM` — Manages individual note state, including title, content, drawing data, and starred status.
    
* **page hierarchy**:

  ```
    LandingPageView -> HomePageView <-> NotePageView/NotePageDrawView
  ```
  * `LandingPageView` — App entry point.
  * `HomePageView` — Displays all notes with filter options and deletion mode.
  * `NotePageView` — Displays a text note for editing or viewing.
  * `NotePageDrawView` — Displays a drawing note with interactive canvas.
  
* **Persistence**: Uses SwiftData queries (`@Query`) for dynamic fetching and filtering of notes.

---

## ❗️ installation

  1) Clone the repository:

  2) Open `Calendrier.xcodeproj` in Xcode 18 or later.

  3) Build and run on a simulator or device running iOS 18+.

---

## [IMPORTANT] dependencies

* **SwiftUI** (iOS 18)
* **Rive** (for animation integration)
* **SwiftData** for data persistence (for now, storage is local to your device)
* **PencilKit** for drawing functionality

---
