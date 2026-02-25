# Unity Environment Guide

> **When to read this**: During Stage 2 (Planning) and Stage 3 (Execution) when the project environment is **Unity (C#)**.

This guide maps the dev workflow's universal principles (OOP, validated data models, strong typing, automated testing) to Unity's ecosystem. The core skill is language-agnostic; this guide provides the concrete tooling.

## Quick Reference

| Principle | Unity Implementation |
|-----------|---------------------|
| **Test Framework** | NUnit (via Unity Test Framework) |
| **Test Runner** | UnityMCP `run_tests` → `get_test_job` |
| **Data Models** | `Model<T>` base class (project-specific), or plain C# classes with constructor defaults |
| **Type System** | C# static typing (compile-time enforced) |
| **Dependency File** | `Packages/manifest.json` (UPM), or vendored in `Assets/` |
| **Dependency Install** | Unity Package Manager, or drop source into `Assets/` |
| **Module Structure** | Folders under `Assets/Scripts/`, optional `.asmdef` assemblies |
| **Inline Verification** | UnityMCP `read_console` (check for compile errors) |
| **Async/Await** | UniTask (`com.cysharp.unitask`) — zero-allocation, PlayerLoop-based |
| **Test File Convention** | `Assets/Tests/Editor/[Component]Test.cs` |

---

## Test Framework: NUnit (Unity Test Framework)

### Test File Naming

`Assets/Tests/Editor/[Component]Test.cs` — e.g., `RemoteConfigModelTest.cs`, `LiveOpsControllerTest.cs`

### Test Class Pattern

```csharp
using NUnit.Framework;

/// <summary>
/// EditMode tests for [component].
/// </summary>
[TestFixture]
public class ComponentTest
{
    [Test]
    public void MethodName_Scenario_ExpectedResult()
    {
        // Arrange
        var model = new MyModel();

        // Act
        var result = model.DoSomething();

        // Assert
        Assert.AreEqual(expected, result);
    }
}
```

### Running Tests

**Run all EditMode tests via UnityMCP:**
```
mcp__UnityMCP__run_tests(mode: "EditMode", include_failed_tests: true)
  → returns job_id

mcp__UnityMCP__get_test_job(job_id: "...", wait_timeout: 60, include_failed_tests: true)
  → returns results
```

**Run specific test assembly:**
```
mcp__UnityMCP__run_tests(mode: "EditMode", assembly_names: ["Assembly-CSharp-Editor"])
```

**Run specific test by name:**
```
mcp__UnityMCP__run_tests(mode: "EditMode", test_names: ["RemoteConfigModelTest.Constructor_ActiveFields_HaveCorrectDefaults"])
```

### Assembly Considerations

When game scripts have **no custom `.asmdef`** (they compile into `Assembly-CSharp`):
- Test files in `Assets/Tests/Editor/` without an `.asmdef` become part of `Assembly-CSharp-Editor`
- `Assembly-CSharp-Editor` can access all game code in `Assembly-CSharp` naturally
- Do **NOT** create a test `.asmdef` — asmdef-defined assemblies cannot reference predefined assemblies like `Assembly-CSharp`

When game scripts **use custom `.asmdef`** assemblies:
- Create a test `.asmdef` with `includePlatforms: ["Editor"]` and reference the game assembly
- Add `optionalUnityReferences: ["TestAssemblies"]` for NUnit access

### Prefer NUnit Tests Over Inline Checks

**NUnit tests are always preferred** for verification. Inline checks via `read_console` are acceptable only for:
- Prerequisites (e.g., "does the project compile?", "is the MCP bridge connected?")
- Step 0 setup verification (e.g., "did the config file update correctly?")

**For implementation steps (Step 1+), always use NUnit tests.**

```
# ✅ Prerequisites/Step 0 - console check OK for compile verification
mcp__UnityMCP__read_console(action: "get", types: ["error"], count: 20)

# ✅ Implementation steps - always NUnit via run_tests
mcp__UnityMCP__run_tests(mode: "EditMode", include_failed_tests: true)
```

---

## UnityMCP: Editor Communication

### Compilation Workflow

After editing `.cs` files, always trigger recompilation:

```
1. mcp__UnityMCP__refresh_unity(mode: "force", compile: "request", wait_for_ready: true)
2. mcp__UnityMCP__read_console(action: "get", types: ["error"], count: 20)
3. If errors → fix and repeat from step 1
```

**Key rule**: Always pass `compile: "request"` — without it, Unity won't recompile until manually focused.

### Console Management

The console accumulates messages. Clear before verifying fixes:

```
mcp__UnityMCP__read_console(action: "clear")
```

### Editor State Polling

If `refresh_unity` times out:

```
ReadMcpResourceTool(server: "UnityMCP", uri: "mcpforunity://editor/state")
→ check data.advice.ready_for_tools
→ if false, wait and retry
```

### Payload Sizing

Large queries can blow up token usage:

| Tool | Recommended `page_size` |
|------|------------------------|
| `manage_scene(get_hierarchy)` | 50 |
| `manage_components(get_components)` | 10-25 (`include_properties: false` first) |
| `manage_asset(search)` | 25-50 (`generate_preview: false`) |

---

## Data Models: C# Classes

### Core Principle

Use **typed C# classes** for all structured data — configs, game state, serialized models. Constructor or field initializers set defaults. Validation in `PostLoad()` or equivalent.

**Why typed classes**: Compile-time type safety, IDE support, serialization via JSON or Unity's built-in serialization. Structured data gets a class; throwaway lookups stay as dictionaries.

### Pattern (MochiBits Model)

```csharp
using Mochibits.MVC;

public class RemoteConfigModel : Model<RemoteConfigModel>
{
    // Field initializers ARE the defaults
    public bool showInterstitial = true;
    public int interstitialFrequency = 4;
    public string skinRatingDialogText = "Please rate us!";
    public List<BonusConfig> bonuses = new List<BonusConfig>();

    /// <summary>
    /// Null-guard recovery. Returns true if any field was corrupted.
    /// </summary>
    public override bool PostLoad()
    {
        bool hasChanges = false;
        if (skinRatingDialogText == null)
        {
            skinRatingDialogText = "";
            hasChanges = true;
        }
        return hasChanges;
    }
}
```

### Pattern (Plain C# — No Base Class)

```csharp
[System.Serializable]
public class EnemyConfig
{
    public float speed = 5f;
    public int health = 100;
    public string displayName = "Enemy";
}
```

### When NOT to Use a Class

- Simple key-value lookups (use `Dictionary<string, object>`)
- Throwaway intermediate data in a single method
- When the data has no invariants to protect

---

## Strong Typing

### C# Enforces Types at Compile Time

Unlike Python where type hints are advisory, C# types are enforced by the compiler. This is a major advantage — many bugs are caught before runtime.

```csharp
public class PlayerService
{
    private readonly GameModel _model;

    public PlayerService(GameModel model)
    {
        _model = model;
    }

    public int GetTotalScore() => _model.score + _model.bonusScore;

    public bool IsEligibleForReward(int threshold) => GetTotalScore() >= threshold;
}
```

### Key Rules

- All fields: explicit types (no `var` for fields)
- All method signatures: parameter types + return types (compiler-enforced)
- Use `List<T>`, `Dictionary<TKey, TValue>` — never untyped collections
- Nullable reference types: use null checks or `?.` operator, guard in `PostLoad()`
- Enums for finite sets of values (not magic strings)

---

## Module Structure

### Project Layout

```
Unity/
├── Assets/
│   ├── Scripts/
│   │   ├── Core/              # Managers, singletons, game model
│   │   ├── Player/            # Player controllers, FSM
│   │   ├── AI/                # AI behavior
│   │   ├── UI/                # UI controllers
│   │   ├── UIFSM/            # UI state machine + controllers
│   │   ├── RemoteConfig/      # Config model + controller
│   │   ├── LiveOps/           # Live operations
│   │   ├── Utilities/         # Helpers, extensions, third-party wrappers
│   │   └── Types/             # Enums, constants
│   ├── Tests/
│   │   └── Editor/            # EditMode NUnit tests
│   ├── Scenes/
│   ├── Prefabs/
│   └── Resources/             # Runtime-loaded assets
├── Packages/
│   └── manifest.json          # UPM dependencies
└── ProjectSettings/
```

### File Conventions

- Source code: `.cs` (one public class per file, filename matches class name)
- Unity metadata: `.meta` (auto-generated, always co-delete with source)
- Tests: `Assets/Tests/Editor/[Component]Test.cs`
- Assembly definitions: `.asmdef` (only when needed for compilation isolation)

---

## OOP Design (Unity/C#-Specific)

### MonoBehaviour vs Plain C#

**MonoBehaviour** — for things attached to GameObjects (scene lifecycle):
```csharp
public class PlayerController : MonoBehaviour
{
    void Start() { /* init */ }
    void Update() { /* per-frame */ }
}
```

**Plain C# classes** — for data, logic, services (no scene dependency):
```csharp
public class RemoteConfig : ModelController<RemoteConfig, RemoteConfigModel>
{
    public bool showInterstitial => model.showInterstitial;

    public void BuildLiveOps() { /* pure logic */ }
}
```

**Principle**: Keep logic in plain C# classes where possible. MonoBehaviours should be thin — delegate to services/models.

### Singleton Pattern

Used for core managers that need global access:
```csharp
public class GameManager : Singleton<GameManager>
{
    public GameModel model;

    public override void Initialize() { /* setup */ }
}
// Access: GameManager.Instance.model.score
```

### Static Readonly Fields (Global Registry)

For non-MonoBehaviour singletons:
```csharp
public static class Global
{
    public static readonly RemoteConfig RemoteConfig = new RemoteConfig();
    public static readonly FirebaseManager FirebaseManager = new FirebaseManager();
}
// Access: Global.RemoteConfig.showInterstitial
```

### Composition Over Inheritance

```csharp
// ✅ Composition — inject dependencies
public class MissionService
{
    private readonly RemoteConfig _config;

    public MissionService(RemoteConfig config)
    {
        _config = config;
    }

    public int GetWaitTime() => _config.missionSetWaitTime;
}

// ❌ Deep inheritance chains
public class BaseEntity : MonoBehaviour { }
public class Mission : BaseEntity { }
public class SpecialMission : Mission { }  // 3 levels deep
```

### Event Communication

Use message systems or C# events for decoupled communication:
```csharp
// Message-based (ootii / custom dispatcher)
MessageManager.AddListener(MessageType.Firebase_RemoteConfigUpdated, OnConfigUpdated);
MessageManager.RemoveListener(MessageType.Firebase_RemoteConfigUpdated, OnConfigUpdated);

// C# delegate events
public static event Action onGameOver;
onGameOver?.Invoke();
```

**Rule**: Use named methods (not lambdas) for `AddListener`/`RemoveListener` so the same reference is used for both.

---

## Async/Await: UniTask

### Why UniTask (Not System.Threading.Tasks)

Unity's `UnitySynchronizationContext.Post` is slow. Standard `Task<T>` captures `ExecutionContext` on every continuation (unnecessary in Unity) and allocates on the heap. UniTask eliminates all of this:

- **Zero allocation** — struct-based, no heap pressure
- **No SynchronizationContext capture** — no `Post` overhead
- **No ExecutionContext flow** — no security context copying
- **PlayerLoop-based scheduling** — runs on Unity's update loop, not thread pool

**Package**: `com.cysharp.unitask` (install via UPM git URL)
**Import**: `using Cysharp.Threading.Tasks;`

### Key Types

| Type | Purpose | Use When |
|------|---------|----------|
| `UniTask` | Awaitable (no result) | Default for async methods |
| `UniTask<T>` | Awaitable with result | Async methods returning a value |
| `UniTaskVoid` | Fire-and-forget | Truly no caller will ever await; MonoBehaviour `Start()` |
| `UniTaskCompletionSource<T>` | Manual completion | Wrapping callback APIs into async |

### async UniTask vs async UniTaskVoid vs async void

```csharp
// DEFAULT — use this. Caller can await, chain, cancel.
async UniTask LoadDataAsync(CancellationToken ct)
{
    await UnityWebRequest.Get(url).SendWebRequest().WithCancellation(ct);
}

// FIRE-AND-FORGET — no completion tracking, slightly more efficient than UniTask
async UniTaskVoid StartAsync()
{
    await LoadDataAsync(this.GetCancellationTokenOnDestroy());
}

// NEVER USE — exceptions swallowed silently, no cancellation, not trackable
async void Bad() { await UniTask.Yield(); }
```

**Rule**: `async UniTask` is the default. `async UniTaskVoid` only for true fire-and-forget (boot sequences, event handlers). Never `async void`.

### .Forget() — Suppressing Compiler Warnings

When calling an `async UniTask` method without awaiting, the compiler warns. `.Forget()` suppresses it:

```csharp
// Fire-and-forget from synchronous context
public void Init_OnLoad()
{
    InitServicesAsync().Forget();
}

static async UniTaskVoid InitServicesAsync()
{
    await UnityServices.InitializeAsync();
}
```

**UniTaskVoid vs .Forget()**: If the method is *always* fire-and-forget, return `UniTaskVoid`. If it *might* be awaited at some call sites, return `UniTask` and use `.Forget()` at fire-and-forget call sites.

### Coroutine Replacements

| Coroutine | UniTask |
|-----------|---------|
| `yield return null` | `await UniTask.NextFrame()` |
| `yield return new WaitForSeconds(n)` | `await UniTask.Delay(TimeSpan.FromSeconds(n))` |
| `yield return new WaitForSecondsRealtime(n)` | `await UniTask.Delay(TimeSpan.FromSeconds(n), ignoreTimeScale: true)` |
| `yield return new WaitForEndOfFrame()` | `await UniTask.WaitForEndOfFrame()` |
| `yield return new WaitForFixedUpdate()` | `await UniTask.WaitForFixedUpdate()` |
| `yield return new WaitUntil(() => cond)` | `await UniTask.WaitUntil(() => cond)` |
| `yield return new WaitWhile(() => cond)` | `await UniTask.WaitWhile(() => cond)` |
| `StartCoroutine(routine)` (fire-forget) | `MethodAsync().Forget()` |

**Yield vs NextFrame**: `UniTask.Yield()` may return the *same frame* if called before that timing has run. `UniTask.NextFrame()` guarantees next frame. Use `NextFrame()` for `yield return null` semantics.

### Cancellation

Always pass `CancellationToken` through async chains. Without it, operations continue after object destruction → `MissingReferenceException`.

```csharp
// Tie to GameObject lifetime
var ct = this.GetCancellationTokenOnDestroy();
await UniTask.Delay(3000, cancellationToken: ct);

// Manual control
var cts = new CancellationTokenSource();
cts.CancelAfterSlim(TimeSpan.FromSeconds(5)); // PlayerLoop-based, not thread pool

// Combine both
var linked = CancellationTokenSource.CreateLinkedTokenSource(
    cts.Token, this.GetCancellationTokenOnDestroy());

// Avoid exception overhead
var (isCanceled, _) = await UniTask.Delay(5000, cancellationToken: ct)
    .SuppressCancellationThrow();
if (isCanceled) return;
```

**Note**: `CancelAfterSlim` is UniTask's replacement for `CancelAfter` — runs on PlayerLoop, not thread pool timer.

### Parallel Execution

```csharp
// WhenAll — returns tuple, enables deconstruction
var (config, assets, user) = await UniTask.WhenAll(
    LoadConfigAsync(), LoadAssetsAsync(), LoadUserAsync());

// WhenAny — first to complete wins
var (winIndex, _) = await UniTask.WhenAny(task1, task2);
```

### Unity AsyncOperation Extensions

```csharp
// Direct await
var asset = await Resources.LoadAsync<TextAsset>("foo");

// With cancellation
var asset = await Resources.LoadAsync<TextAsset>("foo")
    .WithCancellation(ct);

// Full control (progress + timing + cancellation)
var asset = await Resources.LoadAsync<TextAsset>("foo")
    .ToUniTask(progress: Progress.Create<float>(Debug.Log),
               timing: PlayerLoopTiming.Update,
               cancellationToken: ct);
```

### Threading

```csharp
// Offload CPU work to thread pool, return to main thread for Unity API calls
async UniTask<int> ComputeAsync()
{
    await UniTask.SwitchToThreadPool();
    var result = HeavyComputation();
    await UniTask.SwitchToMainThread();
    return result;
}

// One-shot version
var result = await UniTask.RunOnThreadPool(() => HeavyComputation());
```

### Wrapping Callback APIs

```csharp
public UniTask<int> WrapCallbackAsync()
{
    var utcs = new UniTaskCompletionSource<int>();
    SomeAPI(
        onSuccess: result => utcs.TrySetResult(result),
        onError: ex => utcs.TrySetException(ex));
    return utcs.Task;
}
```

### DOTween Integration

Requires scripting define: `UNITASK_DOTWEEN_SUPPORT`

```csharp
var ct = this.GetCancellationTokenOnDestroy();

// Sequential
await transform.DOMoveX(2, 1f).WithCancellation(ct);
await transform.DOMoveZ(5, 2f).WithCancellation(ct);

// Parallel
await UniTask.WhenAll(
    transform.DOMoveX(10, 3).WithCancellation(ct),
    transform.DOScale(2, 3).WithCancellation(ct));
```

### UniTask Tracker (Debug Window)

**Window → UniTask Tracker** — monitors all active UniTask instances. Enable **StackTrace** for creation traces (high overhead, debug only).

---

## Common Pitfalls (Unity/C#)

- **Using raw dictionaries instead of typed classes** (loses compile-time safety, IDE support, self-documentation)
- **Fat MonoBehaviours** — putting all logic in MonoBehaviour instead of plain C# classes (harder to test, violates SRP)
- **Missing null guards on deserialized data** — JSON/PlayerPrefs can produce null fields; always guard in `PostLoad()` or equivalent
- **Using inline console checks for implementation step verification** — use NUnit for Steps 1+ (console checks OK for prerequisites/Step 0)
- **Separating code and tests into different steps** — tests must be written AND run in the same step as the code
- **Creating `.asmdef` for tests when game code has none** — asmdef assemblies cannot reference predefined `Assembly-CSharp`; tests without asmdef naturally access game code
- **Forgetting `compile: "request"` in `refresh_unity`** — Unity won't recompile externally-edited scripts without it
- **Not clearing console before verifying fixes** — console accumulates old errors, leading to false negatives
- **Deleting `.cs` files without co-deleting `.meta` files** — causes Unity orphan warnings
- **Using lambdas for message listeners** — prevents proper `RemoveListener` since lambda creates a new delegate instance each time
- **Using `async void` instead of `async UniTaskVoid`** — `async void` swallows exceptions, has no cancellation support, and is not trackable; use `async UniTaskVoid` for fire-and-forget, `async UniTask` for everything else
- **Forgetting cancellation tokens in async chains** — without `CancellationToken`, async operations continue after `Destroy()`, causing `MissingReferenceException`; always pass `GetCancellationTokenOnDestroy()` or equivalent
- **Using `UniTask.Yield()` expecting next-frame** — `Yield()` may return same frame; use `UniTask.NextFrame()` for guaranteed next-frame behavior
- **Using `async void` lambdas for Unity events** — `button.onClick.AddListener(async () => { ... })` compiles but uses `async void`; use `UniTask.UnityAction(async () => { ... })` instead
