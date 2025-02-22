## 1. Sikkerhet og forbedring av CI/CD-pipelinen (30 poeng)
### Dine Oppgaver:
🔹 **GitHub Actions Workflow:**
- På **feature branches**, skal workflowen kjøre `terraform plan`, men **ikke** `terraform apply`.
- På **main branch**, skal både `terraform plan` og `terraform apply` utføres.

🔹 **Handling Sensitive Values:**
- Infrastrukturkoden og GitHub Actions workflowen **skal ikke inneholde hardkodede hemmeligheter** som for eksempel StatusCake sin API nøkkel.
- . Beskriv og implementer en **sikker løsning** for håndtering av sensetive verdier.

- ``Pipelinen er oppdatert: Den kjører Terraform plan på alle feature-branch og kjører både Terraform plan og Terraform apply for main-branch.``
- ``Og StatusCake API-nøkkelen er flyttet til GitHub Secrets. Når pipelinen kjører, henter den API-nøkkelen fra secret og sender den til terraform apply command som en variable ved hjelp av -var flag.``
---

## 2. Forbedring- og utvidelse av Terraform koden (30 poeng)
🔹 Erstatt **hardkodede verdier** med **variabler** der det gir mening.
🔹 Sett deg inn i [StatusCake sin Terraform-provider ](https://registry.terraform.io/providers/StatusCakeDev/statuscake/latest/docs) og utvid koden med flere ressurser.
🔹 Du må som et minimum opprette en **contact_group**, men du står fritt til å legge til flere ressurser etter eget ønske.
🔹 Lag en **kort beskrivelse** av valgene dine for overvåkning, terskelverdier mm.

- Jeg har lagt til en modul for contact_group 
- Check Interval: Konfigurerbart (check_interval), vanligvis 5 minutter, for å balansere responsivitet og ressursbruk.
- Confirmation: 3 påfølgende feil før en alarm utløses for å unngå falske alarmer.
- Trigger Rate: 10 feil kreves for å utløse en varsling, for å sikre flere feil før varsling sendes.
- Timeout: 20 sekunder ventetid på svar før sjekken anses som mislykket.
- SSL Validation: Aktivert (true) for å sikre et gyldig SSL-certificate.
- Status Codes: Varsler kun for **HTTP-status 200**, som indikerer at nettstedet fungerer som det skal.
- Tags: Tagget som **"production"** for environment organization.
---

## 3. Terraform Modules (30 points)
En av de store fordelene med Terraform er muligheten til å skrive **Gjenbrukbar infrastrukturkode**. SSiden flere avdelinger i bedriften kan ha behov for overvåkning med StatusCake, ønsker vi å lage en **gjenbrukbar modul**.

### Evalueringskriterier:
- I evalueringen vektlegges brukervennligheten til modulen – for eksempel ved at den setter fornuftige standardverdier for terskelverdier og andre innstillinger. Samtidig bør modulen gi brukerne mulighet til å overstyre disse variablene ved behov.

### Oppgave:
🔹 Utvid Terraform-koden slik at den kan overvåke **flere nettsider**. For å unngå repetisjon av kode skal du bruke **Terraform-moduler**.
🔹 Lag en **modul** og bruk den **to ganger** med ulike verdier for minst **to forskjellige nettsider**.

``Ja, det er best practise å bruke moduler for å redusere redundans(Redundancy på engelsk).To moduler er opprettet: en for Contact group og en for StatusCake Uptime. StatusCake Uptime kalles to ganger for to forskjellige nettsteder (vg.no og xkcd) med ulike verdier, og ingenting er hardkodet.``
---

## 4. Håndtering av Terraform State (10 poeng)
Som du kanskje har lagt merke til, er håndteringen av **state files** ikke optimal. For øyeblikket har teamet valgt å sjekke inn Terraform state-filen i GitHub sammen med koden.

Oppgave: Drøft følgende;
🔹 I starten kan denne tilnærmingen fungere, men hvilke konsekvenser kan det få når teamet vokser og flere utviklere jobber med samme repository samtidig?
🔹 Hvilke mekanismer kan brukes for å håndtere Terraform state på en bedre måte?

**Risikoer ved å pushe state-file i GitHub**
- Eksponering av sensitiv data: State-file kan inneholde sårbare data som API-nøkler, passord og annen infrastrukturinformasjon, noe som kan gi uautorisert tilgang til hvem som helst med tilgang til repoet.
- Korrupsjon av state-file: Terraform-state er kritisk for å holde oversikt over infrastrukturen. Hvis flere utviklere kjører terraform apply samtidig med en delt state-file i GitHub, kan det føre til uforutsigbare endringer, eller at du mister oversikt over infrastrukturen.

**Håndtering av Terraform State**
- Bruk ekstern lagring: State file bør lagres i en fjernlagring som en S3 bucket på AWS for å sikre den mot uautorisert tilgang. Kun et begrenset antall personer bør ha tilgang til state-file. I tillegg kan versjonering aktiveres på lagringsløsningen, slik at det er mulig å rulle tilbake til tidligere versjoner ved behov.
- Implementer state-locking: For å unngå at flere utviklere kjører terraform apply samtidig og forårsaker state-korrupsjon eller konflikt i infrastrukturen, bør state-locking implementeres. I AWS kan dette gjøres ved å bruke DynamoDB, som sørger for at Terraform låser state-file under kjøring.