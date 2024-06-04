terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
      version = "> 1.0.0"
    }
  }
}

resource "scalr_provider_configuration" "nested_resource" {
  name                   = "pcfg_${formatdate("HH-mm-ss", timestamp())}"
  custom {
    provider_name = "kubernetes"
    argument {
      name        = "host"
      value       = "my-host"
      description = "The hostname (in form of URI) of the Kubernetes API."
    }
    argument {
      name  = "username"
      value = "my-username"
      description = "probably-centrally-vertically-likely-currently-inherently-repeatedly-strongly-deeply-safely-willingly-clearly-intensely-repeatedly-frankly-lively-duly-blatantly-certainly-weekly-accurately-externally-openly-seriously-miserably-nationally-reliably-slightly-trivially-roughly-socially-equally-openly-severely-mutually-rapidly-infinitely-violently-thoroughly-sincerely-largely-roughly-largely-quickly-amazingly-likely-utterly-namely-only-openly-reliably-initially-surely-firmly-early-rarely-frequently-hopefully"
    }
    argument {
      name      = "password"
      value     = var.password-value
      sensitive = true
    }
  }
}

variable "password-value" {
  default = "AMITX-+@MotyhtsV>0f>b]>6?{#Gr7FRyGQZ0h+z2-J&LJ5nrYSXGb:Jre$F*bREG8Q#h)tmD3>Htr5LTkI)Zp(E#3(}z_&EIh}g}@fwt!tKQF<ZwXg)q!kx(]s=P=}@D*YJ0p5%%u[:>n]-7GQ=Fyc9@CEsu8CcFP5{X_jmcjCnj5Du&:**XXs)g&nn6Og+u(O{:_V@RQSit0v#fzP<JtK58aQBN$5JE0y8?Grkyg[gvwzWIU7mmiuNKwUE9<A<mSxz1Y{EXtX)<c@EgSn[wwy1i&0!U9T$)LvBta7WzKozTgH$m(+Ks5L2Il28KQFL8>[0GqV>+34pG#rN&*h{G73bqOdqmKF4Bx%5$}r)"
}
