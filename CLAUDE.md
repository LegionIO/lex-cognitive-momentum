# lex-cognitive-momentum

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`

## Purpose

Physics-inspired idea momentum engine. Each idea has mass (entrenchment — how deeply embedded it is) and velocity (rate of change). Momentum = mass × velocity. Reinforcement increases both mass and velocity; challenges penalize velocity and slightly reduce mass; external forces apply acceleration (F = ma → a = F/m); friction decays velocity each cycle. Models how entrenched beliefs resist change, how momentum builds through reinforcement, and how challenges slow but rarely immediately reverse well-established ideas.

## Gem Info

- **Gem name**: `lex-cognitive-momentum`
- **Module**: `Legion::Extensions::CognitiveMomentum`
- **Version**: `0.1.0`
- **Ruby**: `>= 3.4`
- **License**: MIT

## File Structure

```
lib/legion/extensions/cognitive_momentum/
  version.rb
  client.rb
  helpers/
    constants.rb
    idea.rb
    momentum_engine.rb
  runners/
    cognitive_momentum.rb
```

## Key Constants

| Constant | Value | Purpose |
|---|---|---|
| `IDEA_TYPES` | `%i[belief goal hypothesis plan intuition]` | Valid idea categories |
| `DEFAULT_MASS` | `0.5` | Starting entrenchment |
| `DEFAULT_VELOCITY` | `0.0` | Starting rate of change |
| `FRICTION_RATE` | `0.05` | Velocity decay per cycle |
| `REINFORCE_MASS_BOOST` | `0.05` | Mass increase per reinforcement |
| `REINFORCE_VELOCITY_BOOST` | `0.1` | Velocity increase per reinforcement |
| `CHALLENGE_VELOCITY_PENALTY` | `0.15` | Velocity decrease per challenge |
| `CHALLENGE_MASS_REDUCTION` | `0.02` | Mass decrease per challenge |
| `MAX_IDEAS` | `200` | Per-engine idea capacity |
| `MAX_HISTORY` | `500` | Momentum event history ring buffer |
| `MOMENTUM_LABELS` | range hash | From `:inert` to `:overwhelming` |
| `INERTIA_LABELS` | range hash | From `:fluid` to `:immovable` |

## Helpers

### `Helpers::Idea`
Individual idea with `id`, `content`, `idea_type`, `domain`, `mass`, `velocity`, and `history` array.

- `momentum` — `mass * velocity`
- `reinforce!` — `mass += REINFORCE_MASS_BOOST`, `velocity += REINFORCE_VELOCITY_BOOST`
- `challenge!` — `velocity -= CHALLENGE_VELOCITY_PENALTY`, `mass -= CHALLENGE_MASS_REDUCTION`
- `apply_force!(force)` — acceleration = force / mass; `velocity += acceleration`
- `apply_friction!` — `velocity -= FRICTION_RATE` (floor 0)
- `surging?` — velocity above a positive threshold
- `reversing?` — velocity is negative
- `at_rest?` — velocity ~0 and momentum ~0
- `entrenched?` — mass above a high threshold
- `momentum_label` / `inertia_label`

### `Helpers::MomentumEngine`
Multi-idea manager.

- `create_idea(content:, idea_type:, domain:, mass:, velocity:)` → idea or capacity error
- `reinforce_idea(idea_id:)` → updated idea
- `challenge_idea(idea_id:)` → updated idea
- `apply_force(idea_id:, force:)` → updated idea
- `surging_ideas` → ideas with positive velocity above threshold
- `reversing_ideas` → ideas with negative velocity
- `entrenched_ideas` → ideas with high mass
- `ideas_by_type(idea_type:)` → filtered list
- `ideas_by_domain(domain:)` → filtered list
- `highest_momentum(limit:)` → top N by momentum
- `most_entrenched(limit:)` → top N by mass
- `apply_friction_all` → friction applied to all ideas
- `prune_at_rest` → removes ideas at rest (momentum ~0)

## Runners

Module: `Runners::CognitiveMomentum`

| Runner Method | Description |
|---|---|
| `create_cognitive_idea(content:, idea_type:, domain:, mass:, velocity:)` | Register a new idea |
| `reinforce_cognitive_idea(idea_id:)` | Reinforce (boost mass + velocity) |
| `challenge_cognitive_idea(idea_id:)` | Challenge (penalize velocity, reduce mass) |
| `apply_cognitive_force(idea_id:, force:)` | Apply external force via F=ma |
| `surging_ideas_report` | Ideas with positive momentum |
| `reversing_ideas_report` | Ideas with reversed momentum |
| `entrenched_ideas_report` | Highly entrenched ideas |
| `highest_momentum_ideas(limit:)` | Top N by momentum |
| `ideas_by_domain(domain:)` | Ideas in a specific domain |
| `update_cognitive_momentum` | Apply friction + prune at-rest ideas |
| `cognitive_momentum_stats` | Aggregate statistics |

All runners return `{success: true/false, ...}` hashes.

## Integration Points

- `lex-tick` `action_selection`: surging ideas bias action selection; reversing ideas signal belief revision in progress
- `lex-prediction`: idea momentum predicts which hypotheses are gaining vs losing traction
- `lex-conflict`: challenging an entrenched idea (high mass) without sufficient force models productive conflict
- `lex-memory`: reinforce memory traces for high-momentum ideas; allow at-rest ideas to decay naturally

## Development Notes

- `Client` instantiates `@momentum_engine = Helpers::MomentumEngine.new`
- Velocity can go negative (reversing), modeling belief reversal
- `apply_friction_all` + `prune_at_rest` together are the tick maintenance call (`update_cognitive_momentum`)
- `FRICTION_RATE = 0.05` means velocity decays in ~20 cycles without reinforcement
- Momentum = mass × velocity: an idea with high mass and zero velocity has zero momentum — mass alone does not drive behavior
