# Hints and tips

## Shared tmux sessions

On one machine

```bash
ssh some-host
tmux new-session -s shared_session
```

On second machine

```bash
ssh some-host
tmux attach-session -t shared_session
```
