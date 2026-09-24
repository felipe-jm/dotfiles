// Mostra a role do modelo ativo (default, smol, slow, plan...) na status line.
// O omp não emite evento de troca de modelo para extensões: /model e Ctrl+P só
// gravam uma entrada `model_change` na sessão, então o intervalo relê essa entrada.
type Ctx = {
  sessionManager: { getBranch(): Array<{ type: string; role?: string }> }
  ui: { setStatus(key: string, text: string | undefined): void }
  setInterval(fn: () => void, ms: number): unknown
}
type Pi = { on(event: string, handler: (event: unknown, ctx: Ctx) => void): void }

function lastModelRole(ctx: Ctx): string {
  const branch = ctx.sessionManager.getBranch()
  for (let i = branch.length - 1; i >= 0; i--) {
    if (branch[i].type === 'model_change') return branch[i].role ?? 'default'
  }
  return 'default'
}

export default function (pi: Pi) {
  let shown: string | undefined

  const refresh = (ctx: Ctx) => {
    const role = lastModelRole(ctx)
    if (role === shown) return
    shown = role
    ctx.ui.setStatus('model-role', `@${role}`)
  }

  pi.on('session_start', (_event, ctx) => {
    shown = undefined
    refresh(ctx)
    ctx.setInterval(() => refresh(ctx), 1000)
  })
  for (const event of ['session_switch', 'session_branch', 'session_tree', 'turn_start']) {
    pi.on(event, (_event, ctx) => refresh(ctx))
  }
}
