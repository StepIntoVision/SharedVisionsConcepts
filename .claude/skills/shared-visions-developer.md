# Shared Visions Developer Skill

Use this skill when creating, modifying, or working with visionOS concept files in the Shared Visions project.

## When to Use This Skill
- Creating new concept files (Concept001.swift, Concept002.swift, etc.)
- Modifying existing concept files
- Working on visionOS SwiftUI or RealityKit code
- Understanding concept types (Window, Volume, Space)

## Creating a New Concept File

### Step 1: Determine the Next Concept Number
Check the `SharedVisionsConcepts01/Concepts/` folder to find the highest existing concept number and increment by 1.

### Step 2: Create the File with Metadata Header
Every concept file MUST start with this metadata block:

```swift
//  Shared Visions Concepts
//
//  Title: ConceptXXX
//
//  Subtitle: Brief descriptive title (shown in list)
//
//  Description: Longer explanation of what this concept demonstrates
//
//  Type: [Window|Volume|Space|Space Full|Window Alt]
//
//  Featured: [true|false]
//
//  Created by [Author] on [M/D/YY].
```

### Step 3: Choose the Correct Type

**WINDOW** - Use for pure 2D SwiftUI content
- Standard SwiftUI views without RealityKit
- Forms, lists, text, buttons, 2D layouts
- Import: `SwiftUI` only

**VOLUME** - Use for 3D content in a bounded space
- RealityKit content in a contained volumetric window
- 3D models, gestures, interactions
- Import: `SwiftUI`, `RealityKit`, `RealityKitContent`

**SPACE** - Use for mixed immersive experiences
- Full spatial content that blends with environment
- Hand tracking, world anchors, unbounded 3D
- Import: `SwiftUI`, `RealityKit`, `RealityKitContent`, optionally `ARKit`

**SPACE FULL** - Use for fully immersive experiences
- Complete takeover of visual space
- VR-style experiences

**WINDOW ALT** - Use for borderless windows
- Plain window style without chrome

## Code Templates

### Window Concept Template
```swift
//  Shared Visions Concepts
//
//  Title: ConceptXXX
//
//  Subtitle: [Your subtitle]
//
//  Description: [Your description]
//
//  Type: Window
//
//  Featured: false
//
//  Created by Joseph Simpson on [Date].

import SwiftUI

struct ConceptXXX: View {
    var body: some View {
        VStack {
            Text("Your content here")
        }
    }
}

#Preview {
    ConceptXXX()
}
```

### Volume Concept Template
```swift
//  Shared Visions Concepts
//
//  Title: ConceptXXX
//
//  Subtitle: [Your subtitle]
//
//  Description: [Your description]
//
//  Type: Volume
//
//  Featured: false
//
//  Created by Joseph Simpson on [Date].

import SwiftUI
import RealityKit
import RealityKitContent

struct ConceptXXX: View {
    var body: some View {
        RealityView { content in
            // Load from Reality Composer Pro
            if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                content.add(scene)
            }

            // Or create programmatically
            let model = ModelEntity(
                mesh: .generateSphere(radius: 0.1),
                materials: [SimpleMaterial(color: .blue, isMetallic: false)]
            )
            content.add(model)
        }
    }
}

#Preview {
    ConceptXXX()
}
```

### Space Concept Template
```swift
//  Shared Visions Concepts
//
//  Title: ConceptXXX
//
//  Subtitle: [Your subtitle]
//
//  Description: [Your description]
//
//  Type: Space
//
//  Featured: false
//
//  Created by Joseph Simpson on [Date].

import SwiftUI
import RealityKit
import RealityKitContent

struct ConceptXXX: View {
    var body: some View {
        RealityView { content in
            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(scene)
            }
        }
        .persistentSystemOverlays(.hidden)
    }
}

#Preview {
    ConceptXXX()
}
```

## Key Conventions

### Naming
- File: `ConceptXXX.swift` (zero-padded 3 digits)
- Struct: Must match filename exactly (`struct ConceptXXX: View`)
- Always end with `#Preview { ConceptXXX() }`

### All Work in One File
- Keep all code for a concept in its single file
- Use `fileprivate` for helper structs, extensions, and functions
- Place helpers at the bottom of the file after the preview

### Common Patterns

**Adding Gestures to RealityKit Entities:**
```swift
model.components.set(InputTargetComponent())
model.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.1)]))
model.components.set(HoverEffectComponent())
```

**Drag Gesture Pattern:**
```swift
.gesture(
    DragGesture()
        .targetedToAnyEntity()
        .onChanged { value in
            value.entity.position = value.convert(
                value.location3D,
                from: .local,
                to: value.entity.parent!
            )
        }
)
```

**Attachments (2D UI in 3D space):**
```swift
RealityView { content, attachments in
    if let panel = attachments.entity(for: "panel") {
        panel.position = [0, 0.5, 0]
        content.add(panel)
    }
} attachments: {
    Attachment(id: "panel") {
        Text("Hello")
            .padding()
            .glassBackgroundEffect()
    }
}
```

### visionOS-Specific Modifiers
- `.glassBackgroundEffect()` - Frosted glass material
- `.hoverEffect()` - Visual feedback on gaze
- `.ornament()` - Floating UI attached to windows
- `.persistentSystemOverlays(.hidden)` - Hide system UI in spaces
- `.offset(z:)` - Push content forward/back in depth

## Project Structure

```
SharedVisionsConcepts01/
├── Tools/
│   └── generate_concepts.swift      # Build script (auto-generates registry)
├── SharedVisionsConcepts01/
│   ├── Concepts/                    # All concept files go here
│   │   ├── Concept001.swift
│   │   ├── Concept002.swift
│   │   └── ...
│   ├── App/
│   │   ├── Generated/
│   │   │   └── ConceptRegistry.swift  # Auto-generated, don't edit
│   │   ├── Model/
│   │   │   └── DirectoryModel.swift
│   │   ├── View/
│   │   │   ├── ConceptList.swift
│   │   │   ├── ConceptDetail.swift
│   │   │   ├── ConceptListRow.swift
│   │   │   └── ConceptRouter.swift
│   │   └── Directory.swift
│   ├── View/                        # Shared views used by concepts
│   ├── Layouts/                     # Custom layout implementations
│   └── Utility/
│       └── Helpers.swift
└── Packages/
    └── RealityKitContent/           # Reality Composer Pro scenes
```

## After Creating a Concept

The build script automatically:
1. Scans all files in `Concepts/` folder
2. Parses metadata from comments
3. Generates `ConceptRegistry.swift`
4. Makes the concept appear in the app's directory

No manual registration needed - just create the file with proper metadata and build the project.

## Tips

1. **Start Simple**: Begin with the appropriate template, then iterate
2. **Test in Preview**: Use Xcode Previews to iterate quickly before running on device
3. **One Concept = One Idea**: Each concept should demonstrate a single focused idea
4. **Document Clearly**: Use Description field to explain what the concept shows
5. **Mark Featured Sparingly**: Only set `Featured: true` for the most important concepts
