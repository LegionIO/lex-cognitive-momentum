# lex-cognitive-momentum

Physics-inspired idea momentum engine for LegionIO cognitive agents. Each idea has mass (entrenchment) and velocity (rate of change). Momentum = mass × velocity. Reinforcement builds momentum; challenges reduce it; friction decays velocity each cycle.

## What It Does

- Five idea types: `belief`, `goal`, `hypothesis`, `plan`, `intuition`
- Reinforce ideas to increase mass and velocity
- Challenge ideas to penalize velocity and reduce mass
- Apply external forces via Newton's second law (F = ma)
- Friction decays velocity each tick cycle
- Prune ideas that reach zero momentum (at rest)
- Identify surging (positive velocity), reversing (negative velocity), and entrenched (high mass) ideas

## Usage

```ruby
# Create an idea
result = runner.create_cognitive_idea(
  content: 'microservices will reduce coupling',
  idea_type: :hypothesis, domain: :architecture,
  mass: 0.5, velocity: 0.0
)
idea_id = result[:idea][:id]

# Reinforce it
runner.reinforce_cognitive_idea(idea_id: idea_id)
# => { success: true, idea: { mass: 0.55, velocity: 0.1, momentum: 0.055, ... } }

# Challenge it
runner.challenge_cognitive_idea(idea_id: idea_id)
# => { success: true, idea: { velocity: -0.05, ... } }

# Apply external force
runner.apply_cognitive_force(idea_id: idea_id, force: 0.3)

# Tick maintenance (friction + prune)
runner.update_cognitive_momentum

# Identify what's moving
runner.surging_ideas_report
runner.entrenched_ideas_report
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
