
terraform {
  backend "remote" {
    hostname = "annn.master-ann1.testenv.scalr.dev"
    organization = "env-v0o427ut64dq78b2f"
    token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzZXJ2aWNlLWFjY291bnQiLCJqdGkiOiJhdC12MG80aW40ajVkM3BqY2E2ciIsInN1YiI6InNhLXYwbzQyN3V0NjdoMzhpYzNvIn0.IjsObIW3DK5W_4g8FuM0OgzrBcJlksEYwxem779XO5w"
    workspaces {
      name = "big"
    }
  }
}





terraform {
    required_providers {
        scalr = {
            source = "registry.scalr.io/scalr/scalr"
            version= "1.5.0"
        }
    }
}

variable "basic" {
  default = "ABC123"
}

variable "initial" {
  default = "INITIAL_heartily-violently-miserably-newly-adequately-hardly-accurately-publicly-previously-finally-duly-readily-equally-regularly-socially-partially-barely-evidently-loosely-fairly-multiply-weekly-early-informally-vastly-verbally-newly-roughly-apparently-gratefully-primarily-privately-widely-verbally-frequently-visually-tightly-kindly-genuinely-sadly-enormously-centrally-notably-reliably-openly-apparently-solely-urgently-presently-rarely-weekly-newly-monthly-morally-preferably-utterly-openly-gratefully-positively-gratefully-equally-firstly-seemingly-usefully-frequently-literally-gradually-subtly-lively-abnormally-utterly-secondly-slightly-reasonably-really-rationally-scarcely-firstly-lively-optionally-openly-rarely-possibly-wholly-amazingly-especially-badly-severely-possibly-openly-personally-admittedly-mildly-partly-really-legally-sincerely-willingly-seriously-partly-immensely-infinitely-closely-firmly-strangely-lately-reliably-properly-forcibly-daily-friendly-obviously-singularly-barely-entirely-wholly-nominally-morally-only-physically-supposedly-gratefully-poorly-factually-curiously-mildly-live-burro"
}

variable "replacement" {
  default = "wholly-quickly-quickly-publicly-separately-early-endlessly-highly-jolly-infinitely-hopefully-wholly-deadly-thankfully-really-gratefully-adequately-sharply-overly-evidently-thoroughly-readily-terminally-greatly-entirely-likely-literally-conversely-loosely-supposedly-deeply-instantly-cheaply-similarly-gratefully-ideally-suitably-rightly-kindly-mutually-probably-horribly-specially-quietly-initially-factually-poorly-formally-informally-luckily-partially-hugely-rapidly-evidently-slightly-arguably-positively-suitably-wildly-eminently-notably-vigorously-easily-purely-loudly-factually-gratefully-admittedly-closely-rarely-loudly-positively-gradually-reliably-recently-illegally-globally-reasonably-scarcely-gratefully-badly-mainly-vastly-newly-actively-clearly-noticeably-readily-wildly-kindly-actually-willingly-naturally-supposedly-gently-grossly-centrally-openly-centrally-illegally-honestly-infinitely-remarkably-vigorously-yearly-amazingly-cheaply-visually-notably-jolly-adversely-mutually-heartily-closely-reliably-reasonably-physically-arguably-rarely-legally-incredibly-daily-loosely-briefly-positively-implicitly-neat-giraffe"
}

variable "question" {
  description = "What variable to use as a trigger for the null_resource.long_triggers_replacement? Options: initial, replacement."
  default = "initial"
}

resource "scalr_provider_configuration" "kubernetes" {
  count = 5000
  name       = "k8s-${count.index}"
  account_id = "acc-v0o4hljm8n2orejgm"
  custom {
    provider_name = "kubernetes"
    argument {
      name        = "host"
      value       = "https://kubernetes.io/"
      description = "The hostname (in form of URI) of the Kubernetes API."
    }
    argument {
      name  = "username"
      value = "my-username"
    }
    argument {
      name      = "password"
      value     = "my-password"
      sensitive = true
    }
    argument {
      name  = "arg1"
      value = "my-arg1"
    }
    argument {
      name  = "arg2"
      value = "my-arg2"
    }
    argument {
      name  = "arg3"
      value = "my-arg3"
    }
    argument {
      name  = "arg4"
      value = "my-arg4"
    }
    argument {
      name  = "arg5"
      value = "my-arg5"
    }
    argument {
      name  = "arg6"
      value = "my-arg6"
    }
    argument {
      name  = "arg7"
      value = "my-arg7"
    }
    argument {
      name  = "arg8"
      value = "my-arg8"
    }
    argument {
      name  = "arg9"
      value = "my-arg9"
    }
    argument {
      name  = "arg10"
      value = "my-arg10"
    }
    argument {
      name  = "arg11"
      value = "my-arg11"
    }
    argument {
      name  = "arg12"
      value = "my-arg12"
    }
    argument {
      name  = "arg13"
      value = "my-arg13"
    }
    argument {
      name  = "arg14"
      value = "my-arg14"
    }
    argument {
      name  = "arg15"
      value = "my-arg15"
    }
    argument {
      name  = "arg16"
      value = "my-arg16"
    }
    argument {
      name  = "arg17"
      value = "my-arg17"
    }
    argument {
      name  = "arg18"
      value = "my-arg18"
    }
    argument {
      name  = "arg19"
      value = "my-arg19"
    }
    argument {
      name  = "arg20"
      value = "my-arg20"
    }
    argument {
      name  = "arg21"
      value = "my-arg21"
    }
    argument {
      name  = "arg22"
      value = "my-arg22"
    }
    argument {
      name  = "arg23"
      value = "my-arg23"
    }
    argument {
      name  = "arg24"
      value = "my-arg24"
    }
    argument {
      name  = "arg25"
      value = "my-arg25"
    }
    argument {
      name  = "arg26"
      value = "my-arg26"
    }
    argument {
      name  = "arg27"
      value = "my-arg27"
    }
    argument {
      name  = "arg28"
      value = "my-arg28"
    }
    argument {
      name  = "arg29"
      value = "my-arg29"
    }
    argument {
      name  = "arg30"
      value = "my-arg30"
      description = "test description"
      sensitive = "false"
    }
    argument {
      name  = "arg31"
      value = "my-arg31"
    }
    argument {
      name  = "arg32"
      value = "my-arg32"
    }
  }
}

resource "null_resource" "countable" {
  count = 5
  triggers = {
    time = timestamp()
  }
}

resource "terraform_data" "replace_trigger" {
  input = var.basic
}

resource "random_string" "long_id_string" {
  length           = 1024 # characters
  lower            = true
  numeric          = true
  special          = true
  upper            = true
  min_lower        = 64
  min_numeric      = 64
  min_special      = 64
  min_upper        = 64
  override_special = <<EOT
    CeeF2TzvB@burp0EorS914cbeWA9wn*=
    URpcah*JSo@3q13xZvp$ZmnBfp@okaTO
    rrAbvkQ!Gc$PWeDm9H&42@ZT@7#t!j#+
    ER@ekXud58%%b&f+3Ecj7yuYej469jAh
    %@NY$CTMSNo*YaK6mB%S#1&Ns$+QN#Qe
    Dsrj6O8NQosfwh!FP&2Bnvz8Yr6AD2@R
    Kht@jwWhO0VoC%@K8rQZ4!HY096ajx0$
    76n$jn5WNNuST!@$FEp8Zd@eapYMnHsx
    @#V9vDTNvKfhgzgZhO8+ukFERy*K+2u%
    G2B$2g1z#U1jst&gkVGeSm4wA6pJ%M%s
    TNnd3cPsCPAW9bM7rZDT3K76aZShuve8
    dqE8yyNaxv4vbkWoqb7e0#D0P@5!uAXo
    uR*fP0vwG+*1Uo37dFx#H6Bea86xAg6N
    RujKnROothsCg$gqo4YDJyyoF%mbgjT2
    9g!9PQpvRKAS9ABX&TTV+wNx!TBymEc3
    !$ONb&vYjXu0eMVCR=&DK*XMJ+rG&y=d
    $Kk1@HfkmsCx82NvBj&3Usja5@eX2Dpm
    !$$F0bvpc5BPeaH&B8e62$Xr54D*Y*%M
    oDK+oDT@KTXt=ACQkEEQJjnee0Ka0Xoy
    MY0MU!9prR=yODEE%v*$xpdGVMhobOeb
    aY5MZCKOX1nY!*AsXQTo5PRgYx%YAax&
    Nvo6JXR$*Ut0pa@mA9K=$REFxE$5ru+q
    r$JmZphE&ZqUk2sJeBVEufEVOeGUhO#t
    =y=WpWJBMVznrJ+Ds#c+OFvPPBBaqdxt
    H%pY9tcV$+@&*!ZbV6P%A6u4QVReR3hV
    KGJ+Rzt@R4w+9WC6=PS56Yo0R%Ug+1b&
    55WaSSXEu6&eKt@K09bNnHg2Xg%4gBpN
    yE++jgCwMj98QtZC$4TbHfA@Kp9#FVCX
    @PjSWcRZ=3DA@Bz&z*QvJwj%bDnuk4&S
    Qq0!!&M%Obq5NzEa3YGmmu2&MM4KwNF4
    t5+7zY0+hdXp!!0&wrykyse0mfYbgkTr
    =+9DEqaZMjr!PEhM=5YADMgn%Pw$563Q
    U+8BrfP9FZtqtCAo52Vhj&@C6Y2@Cs+h
    0Z7$&A9K1cf6uxAJk0RoK9kskZN*Muy#
    gSYfeNGu&VXuAvXRty7mQx64t&XFy&96
    0WXPQO%1x3OgKYa2sNpaXWdA$$frjYG*
    w6HdssxB3!Y5z@RYdwN!Na02%VwcKGND
    BZkQOdcZ*%3r4Tt&G6@GfB4=bc!!@Yuh
    ystX=Pb%y5wPm7%70x4Y7gDoerof17c5
    2a#od=j1JpA8*e1rasSe!ogxjz7R7SNJ
  EOT

  lifecycle {
    replace_triggered_by = [terraform_data.replace_trigger]
  }
}

resource "null_resource" "long_triggers_replacement" {
  triggers = {
    # condition ? true_val : false_val
    long = var.question != "initial" ? var.replacement : var.initial
  }
}
