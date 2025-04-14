# **✅ Part 1: Visual, Animation & Audio Polish Checklist**

🎨 Code-independent visual tasks to make your UI feel juicy, readable, responsive, and alive.

---

## **🧩 Global UI Polish**

### **🖼️ General Aesthetic**

- [ ] Set cohesive color palette (dialogue boxes, backgrounds, cursors)

- [ ] Apply theme fonts (per character or per player)

- [ ] Use screen-space shaders for soft focus, vignette, or color grading

- [ ] Add subtle parallax or background movement

---

## **🎯 ChoiceButton Polish**

### **🖌️ Visual Styling**

- [ ] Background hover highlight (tint, border glow, or scale pulse)

- [ ] Selected state visual (brief flash or zoom before fading)

- [ ] Denied state visual (shake, red flash)

- [ ] Disable/unhovered state (desaturate or dim)

### **🎞️ Animations (AnimationPlayer or Tween)**

- [ ] `"hover"`: scale up or pulse

- [ ] `"chosen"`: fade out, zoom, slide, or bounce

- [ ] `"denied"`: shake, flicker, color flash

- [ ] `"appear"`: fade in with slight move or delay (nice for batch button drops)

- [ ] `"reset"`: fade or scale back to neutral

### **🔊 Audio Cues**

- [ ] Hover → soft blip/click

- [ ] Select → confident tone or UI "stamp"

- [ ] Denied → error or buzz sound

- [ ] Appear → soft pop or sweep-in

---

## **📋 ContinueButton Polish**

- [ ] Hover effect (subtle scale or glow)

- [ ] Sound cue on press

- [ ] Short "next" animation (e.g., button slides/fades when pressed)

- [ ] Optional "sync wait" animation (pulsing or loading state)

---

## **🖱️ Cursor Feedback**

- [ ] Change sprite color when hovering own buttons

- [ ] Flash red or shake when hovering another player’s button

- [ ] Optional "idle pulse" effect when still

---

## **📝 Dialogue History & Current Text Polish**

- [ ] ScrollContainer: smooth scroll with joystick

- [ ] Add fade-in effect on new paragraph

- [ ] Slight text "typewriter" reveal for current text

- [ ] Background opacity / readability tuning

- [ ] Auto-scroll to bottom on new history append

---

## **🔄 Transitions & Flow**

- [ ] Fade-in at game start

- [ ] Optional scene transition fade when changing nodes

- [ ] Animation to hide previous ChoiceButtons when new ones spawn

- [ ] Sync lock icon \+ pulse when waiting for other player

---

## **🎵 Music & Ambience**

- [ ] Add looping ambient track (forest, cave, static)

- [ ] Optional SFX triggers from dialogue events (wind, footsteps, UI blips)

- [ ] Low-pass filter or muffle effect during sync points or tension

- [ ] Use trigger system to switch audio layers on events

---

## **🧠 Presentation Notes**

- [ ] Use consistent timing for animations (ease in/out \~0.2s–0.4s)

- [ ] Keep cursor motion responsive (acceleration/deceleration optional)

- [ ] Animate based on **player identity** (e.g., blue vs red cursor trails)

- [ ] Consider subtle feedback when **choices become unavailable**

---

## **📁 File Organization Tips**

- [ ] Create `res://assets/audio/ui/` for button sounds

- [ ] Create `res://assets/anim/choice_buttons/` for animations

- [ ] Create `res://themes/` for text/fonts/colors/styles

- [ ] Optional `res://vfx/` for shaders/glitches/flickers

