terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
      version = "> 1.0.0"
    }
  }
}


# ----------------------------------------------------------------------------------------- #

module "long-module-name-" {
  source = "./nested"
  password-value = "AMITX-+@MotyhtsV>0f>b]>6?{#Gr7FRyGQZ0h+z2-J&LJ5nrYSXGb:Jre$F*bREG8Q#h)tmD3>Htr5LTkI)Zp(E#3(}z_&EIh}g}@fwt!tKQF<ZwXg)q!kx(]s=P=}@D*YJ0p5%%u[:>n]-7GQ=Fyc9@CEsu8CcFP5{X_jmcjCnj5Du&:**XXs)g&nn6Og+u(O{:_V@RQSit0v#fzP<JtK58aQBN$5JE0y8?Grkyg[gvwzWIU7mmiuNKwUE9<A<mSxz1Y{EXtX)<c@EgSn[wwy1i&0!U9T$)LvBta7WzKozTgH$m(+Ks5L2Il28KQFL8>[0GqV>+34pG#rN&*h{G73bqOdqmKF4Bx%5$}r)"
}

# ----------------------------------------------------------------------------------------- #

resource "null_resource" "countable" {
  count = 3
  triggers = {
    time = timestamp()
  }
}

resource "null_resource" "provisioning" {
  triggers = {
    null_resource_ids = join(",", null_resource.countable[*].id)
  }

  provisioner "local-exec" {
    command     = "echo 'THIS RESOURCE IS DESTOYED NOW'"
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = continue
    environment = {
      DESTROY_VARIABLE_1 = "Lorem"
      DESTROY_VARIABLE_2 = "Ipsum"
      DESTROY_VARIABLE_3 = 1
    }
    quiet = false
  }

  provisioner "local-exec" {
    command     = "echo 'THIS RESOURCE IS CREATED NOW'"
    interpreter = ["/bin/bash"]
    on_failure  = continue
    environment = {
      APPLY_VARIABLE_1 = "Lorem"
      APPLY_VARIABLE_2 = "Ipsum"
      APPLY_VARIABLE_3 = 1
    }
  }
}

# ----------------------------------------------------------------------------------------- #

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

# ----------------------------------------------------------------------------------------- #

resource "random_pet" "long-named-pet-consisting-of-words-and-characters-with-dashes-and-underscores-to-reach-a-total-length-of-200-characters-in-accordance-with-your-request-to-include-words-dashes-underscores-and-lowercase-letters" {
  length    = 3
  prefix    = "NNNZWANOAJAPVKHYDJBDSNUANRKBRXHQRDBCSAVKGKXHOWXYCCDCNYGFSQUGQLBYNBFFWZJPGMRAUDKBIEYMGJWERJACQIMJQOZK"
  separator = "SEPARATOR"
  keepers = {
    key-keeper = join(", ", values(var.triggers_to_be_joined))
  }
}

# ----------------------------------------------------------------------------------------- #

resource "scalr_workspace" "cli-ws_to-be-updated-on-rerun" {
  name           = "workspace_${formatdate("HH-mm-ss", timestamp())}"
  environment_id = var.env-id

  working_directory           = "example/path"
  auto_apply                  = true
  auto_queue_runs             = "never"
  force_latest_run            = false
  var_files                   = ["some-variables-file-with-aabsurdly-long-name.tfvars.json"]
  deletion_protection_enabled = false
  hooks {
    pre_init  = "printenv"
    pre_plan  = "some long string that won't be valid as a custom hook but still can be used for tests"
    pre_apply = "YO 1337"
  }
}

# ----------------------------------------------------------------------------------------- #

resource "random_password" "sensitive_values_as_keepers" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  keepers = {
    credentials = join("/", values(var.secrets))
  }
  upper     = var.change_me_upper
  min_lower = var.change_me_min_lower
}

resource "random_id" "name" {
  byte_length = 128
  keepers = {
    sanitized = var.marked_as_sensitive_on_UI
  }
}

# ----------------------------------------------------------------------------------------- #

resource "null_resource" "multiple_triggers" {
  triggers = {
    order               = "The Adepta Sororitas, also known as the Sisters of Battle, are a fervent and devout military arm of the Ecclesiarchy, the religious institution of the Imperium of Man. The Order of the Sacred Rose is one of the most esteemed and revered Orders Militant among them. Its sisters are known for their unyielding faith in the Emperor's Divine Faith and their exceptional marksmanship with the holy Bolter, which they see as a sacred instrument of cleansing. The Order's central abbey, the Convent Sanctorum, is a fortress of devotion, and Abbess Sanctorum Junith Eruita is its resolute leader."
    abbess              = "Abbess Sanctorum Junith Eruita is a living legend among the Sisters of Battle. She is known for her unwavering devotion to the Emperor and her exceptional battlefield leadership. Abbess Sanctorum Eruita has led her sisters to numerous victories against the enemies of the Imperium, often wielding the holy Bolter with unparalleled skill. Her leadership inspires those under her command, and she is regarded as a true paragon of faith and martial prowess."
    faith               = "The Adepta Sororitas hold the Emperor's Divine Faith in the highest regard. Their unwavering belief in the Emperor's divinity fuels their righteous fury on the battlefield. Their faith is a shield against the horrors of the galaxy, and it empowers them to confront heresy and chaos wherever it may be found. The Sisters of Battle see themselves as the Emperor's chosen warriors, and they fight with the conviction that their every action is a testament to their faith."
    weapon              = "The Bolter is the standard weapon of the Adepta Sororitas, a sacred instrument of cleansing and purging. These holy firearms fire explosive bolts and are highly effective against the enemies of the Imperium. The Sisters of Battle wield Bolters with precision and discipline, turning them into deadly tools of faith and righteousness on the battlefield."
    faithful_servant    = "Confessor Seraphicus is a prominent figure among the Adepta Sororitas. He is a charismatic preacher and a staunch defender of the Emperor's faith. Confessor Seraphicus travels alongside the Sisters of Battle, delivering fiery sermons, and ensuring that their faith remains unshaken. His presence on the battlefield inspires the faithful and strikes fear into the hearts of heretics."
    holy_relic          = "Purity Seals blessed by Saint Celestine are highly revered relics among the Sisters of Battle. These seals are believed to offer divine protection to those who carry them. They are often affixed to Sororitas Power Armor or vehicles, serving as a symbol of purity and devotion to the Emperor."
    convent             = "The Convent Sanctorum is the central abbey of the Order of the Sacred Rose. It is a massive fortress of faith and devotion, housing countless sisters in arms. The Convent Sanctorum serves as a bastion against the forces of heresy and chaos, and its hallowed halls echo with the prayers and battle cries of the Sisters of Battle."
    prayer              = "The Litany of Faith is a powerful prayer recited by the Sisters of Battle before they enter battle. It invokes the Emperor's protection and asks for His guidance in the righteous cleansing of the galaxy. The words of the litany are a source of strength and resolve for the faithful warriors of the Adepta Sororitas."
    militant_order      = "The Daughters of the Emperor, as the Adepta Sororitas are often called, are a militant order of warrior-nuns dedicated to the defense of humanity and the eradication of heresy. They are renowned for their unwavering faith and combat prowess. Their mission is to enforce the Emperor's will and protect the Imperium from all threats."
    hymn                = "The Hymn of the Ecclesiarchy is a sacred song sung by the Sisters of Battle during religious ceremonies. It is a solemn and beautiful melody that praises the Emperor's divine authority and the righteousness of their cause. The hymn's lyrics serve as a reminder of their sacred duty and the importance of their faith."
    righteous_fury      = "Righteous Fury is the battle fervor that burns within the hearts of the Sisters of Battle. It is the unshakeable belief in the Emperor's divine authority and the conviction that their every action is a testament to their faith. Righteous Fury fuels their determination to confront the enemies of the Imperium, no matter the odds."
    inquisitor          = "Inquisitor Karamazov is a zealous and ruthless servant of the Imperium. He often works alongside the Adepta Sororitas to root out heresy and corruption. His formidable presence strikes fear into the hearts of heretics, and he is known for his unyielding pursuit of the Emperor's justice."
    martyr              = "Saint Katherine of the Emperor's Grace is a revered martyr and symbol of faith among the Sisters of Battle. Her story inspires countless Sisters to embrace their faith and sacrifice for the Imperium. Her legacy serves as a shining example of unwavering devotion."
    repentance          = "The Sisters of Battle firmly believe in the doctrine of repentance. They see it as a path to redemption for those who have strayed from the Emperor's light. The phrase 'Repent! For tomorrow you die!' is often used to emphasize the urgency of returning to the Emperor's grace before facing judgment."
    faithful_armor      = "Sororitas Power Armor is a symbol of the Sisters' unwavering faith and martial prowess. It is a formidable suit of armor that provides both protection and mobility. Adorned with holy icons and purity seals, the armor is a testament to the Sisters' dedication to the Emperor's Divine Faith."
    faithful_battle_cry = "The battle cry 'For the Emperor and Sanguinius!' is a rallying call for the Sisters of Battle. It honors both the God-Emperor and the Primarch Sanguinius, a legendary figure in Imperial history. The cry instills courage and determination in the faithful warriors as they charge into battle."
    repentia_squad      = "The Penitent Engine is a grim and terrifying instrument of punishment and redemption used by the Sisters of Battle. It is a hulking war machine piloted by repentant Sisters who seek to atone for their sins through battle. The Penitent Engine is a symbol of the Sisters' commitment to their faith."
    sororitas_purity    = "Purity is the armor of the Sisters of Battle, shielding them from the impurities and taint of the galaxy. It is their unwavering devotion to the Emperor's Divine Faith that makes them impervious to the temptations of heresy and chaos. Purity is their strength."
    holy_warrior        = "Celestian Sacresants"
    chapter_house       = "Convent Prioris"
    seraphim            = "Seraphim Squad"
    melta_gun           = "Multi-Melta"
    purifier            = "Purgation Squad"
    flamer              = "Heavy Flamer"
    sisters_repentia    = "Repentia Superior"
    arthas_militant     = "Arco-Flagellants"
    immolator           = "Immolator Tank"
  }
}

# ----------------------------------------------------------------------------------------- #

data "scalr_policy_group" "pg_reference" {
  id         = var.pg-reference-id
 depends_on = [ null_resource.countable[0] ]
}

resource "scalr_policy_group" "object_known_after_apply" {
  name            = "policy_${formatdate("HH-mm-ss", timestamp())}"
  opa_version     = "0.55.0"
  vcs_provider_id = data.scalr_policy_group.pg_reference.vcs_provider_id
  vcs_repo {
    identifier = data.scalr_policy_group.pg_reference.vcs_repo[0].identifier
    path       = data.scalr_policy_group.pg_reference.vcs_repo[0].path
    branch     = data.scalr_policy_group.pg_reference.vcs_repo[0].branch
  }
}

resource "scalr_environment" "list_known_after_apply" {
  name       = "environment_${formatdate("HH-mm-ss", timestamp())}"
  cost_estimation_enabled = true
  policy_groups = [ scalr_policy_group.object_known_after_apply.id]
}

# ----------------------------------------------------------------------------------------- #

# resource "scalr_provider_configuration" "nested_resource" {
#   name                   = "pcfg2_${formatdate("HH-mm-ss", timestamp())}"
#   custom {
#     provider_name = "kubernetes"
#     argument {
#       name        = "host"
#       value       = "my-host"
#       description = "The hostname (in form of URI) of the Kubernetes API."
#     }
#     argument {
#       name  = "username"
#       value = "my-username"
#       description = "probably-centrally-vertically-likely-currently-inherently-repeatedly-strongly-deeply-safely-willingly-clearly-intensely-repeatedly-frankly-lively-duly-blatantly-certainly-weekly-accurately-externally-openly-seriously-miserably-nationally-reliably-slightly-trivially-roughly-socially-equally-openly-severely-mutually-rapidly-infinitely-violently-thoroughly-sincerely-largely-roughly-largely-quickly-amazingly-likely-utterly-namely-only-openly-reliably-initially-surely-firmly-early-rarely-frequently-hopefully"
#     }
#     argument {
#       name      = "password"
#       value     = "AMITX-+@MotyhtsV>0f>b]>6?{#Gr7FRyGQZ0h+z2-J&LJ5nrYSXGb:Jre$F*bREG8Q#h)tmD3>Htr5LTkI)Zp(E#3(}z_&EIh}g}@fwt!tKQF<ZwXg)q!kx(]s=P=}@D*YJ0p5%%u[:>n]-7GQ=Fyc9@CEsu8CcFP5{X_jmcjCnj5Du&:**XXs)g&nn6Og+u(O{:_V@RQSit0v#fzP<JtK58aQBN$5JE0y8?Grkyg[gvwzWIU7mmiuNKwUE9<A<mSxz1Y{EXtX)<c@EgSn[wwy1i&0!U9T$)LvBta7WzKozTgH$m(+Ks5L2Il28KQFL8>[0GqV>+34pG#rN&*h{G73bqOdqmKF4Bx%5$}r)"
#       sensitive = true
#     }
#   }
# }

# ----------------------------------------------------------------------------------------- #

resource "null_resource" "long_triggers_replacement" {
  triggers = {
    # condition ? true_val : false_val
    long = var.question != "initial" ? var.replacement : var.initial
  }
}

resource "scalr_provider_configuration" "kubernetes" {
  name       = "k8s"
  custom {
    provider_name = "kubernetes"
    argument {
      name        = "host"
      value       = <<EOT
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
first line
EOT
      description = "The hostname (in form of URI) of the Kubernetes API."
    }
  }
}

