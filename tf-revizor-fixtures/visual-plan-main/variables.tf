variable "triggers_to_be_joined" {
  type = map(string)
  default = {
    name           = "John Doe"
    age            = "31"
    city           = "New York"
    country        = "United States"
    favorite_color = "Blue"
    occupation     = "Software Engineer"
    education      = "Bachelor's Degree"
    hobby          = "Photography"
    team           = "Terraform Enthusiasts"
    project        = "Infrastructure Automation"
    company        = "TechCorp Inc."
    status         = "Active"
    email          = "john.doe@example.com"
    phone          = "+1 (555) 123-4567"
    website        = "https://www.example.com"
    timezone       = "UTC-5"
    start_date     = "2022-01-15"
    end_date       = "2022-12-31"
    salary         = "80000"
  }
}

variable "basic" {
  default = "ABC123"
}

variable "layered" {
  type = object({
    layer1 = object({
      layer2 = object({
        layer3 = object({
          value1 = string
          value2 = string
          value3 = string
        })
      })
    })
  })
  default = {
    layer1 = {
      layer2 = {
        layer3 = {
          value1 = "Value for Layer 1"
          value2 = "Value for Layer 2"
          value3 = "Value for Layer 3"
        }
      }
    }
  }
}

variable "env-id" {
  description = "ID of the environment to create workspace in"
}

variable "secrets" {
  type = object({
    username = string
    password = string
  })
  sensitive = true
  default = {
    username = "admin"
    password = "c!Sx&n8MfZ#jK$4E"
  }
}

variable "marked_as_sensitive_on_UI" {
  description = "Set any value here, but mark as sensitive via Scalr UI"
}


variable "change_me_upper" {
  type        = bool
  description = "CHANGE ME TO 'false'"
  default     = true
}

variable "change_me_min_lower" {
  type        = number
  description = "CHANGE ME TO '10'"
  default     = 2
}


variable "pg-reference-id" {
  description = "ID of the exisiting policy group for the data_source. Exisiting policy group will be used as a reference and the duplicate will be created."
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
