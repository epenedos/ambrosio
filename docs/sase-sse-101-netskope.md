# SASE e SSE 101, e como a Netskope os endereça

Preparado para: Dudu (Eduardo Penedos) | Data: 2026-10-19 | Modo: análise técnica
Âmbito: introdução conceptual. A Netskope é concorrente da Palo Alto Networks (Prisma SASE); o tom é factual e neutro.
Convenção: **[V]** = verificado numa fonte indicada; **[S]** = só visto em fonte secundária (imprensa, reimpressões de fornecedor); **[NV]** = não verificado.

---

## 1. Resumo executivo

- SASE (Secure Access Service Edge) é um modelo em que rede (SD-WAN) e segurança (SWG, CASB, ZTNA, FWaaS) são entregues como serviço na cloud, em vez de passarem por um perímetro no datacenter. A Gartner definiu-o em 2019.
- SSE (Security Service Edge) é a metade de segurança do SASE, sem a parte SD-WAN. A Gartner passou a tratá-lo como categoria própria em 2021.
- A Netskope vende uma plataforma (Netskope One) assente em SSE, com rede privada própria (NewEdge) e SD-WAN (Borderless SD-WAN, vinda da Infiot, 2022). O foco declarado é a proteção de dados e, mais recentemente, a governação de IA generativa.
- A Netskope tem sido posicionada como Leader no Magic Quadrant da Gartner para SSE desde a primeira edição (2022), segundo o próprio fornecedor e imprensa [V/S].
- Para a tua área: ZTNA e SASE dependem de identidade (IdP, MFA, contexto). Contas privilegiadas, identidades de máquina e agentes de IA são o lado que o SSE só cobre parcialmente. É aí que a conversa com a Idira se encaixa.

---

## 2. O que é SASE

**Origem.** A Gartner introduziu o termo em agosto de 2019, no relatório "The Future of Network Security Is in the Cloud" (publicado a 30 de agosto de 2019) **[S]**: o texto integral exige registo; a data e o título vêm de reimpressões de fornecedores (Palo Alto Networks, Zscaler, Cato). Não confirmei os nomes dos autores de forma independente.

**Problema que resolve.** O modelo antigo assumia utilizadores e aplicações dentro do perímetro da empresa, com tráfego a passar por firewalls e VPN no datacenter. Três mudanças quebraram-no:

1. As aplicações mudaram para SaaS e IaaS/PaaS (o tráfego já não "vem para casa").
2. O trabalho remoto e híbrido tirou os utilizadores do escritório.
3. O perímetro deixou de existir como ponto único de controlo; a identidade e o contexto passam a ser o novo controlo (ideia de zero trust, ver NIST SP 800-207).

Fazer o tráfego remoto voltar ao datacenter (backhauling) é lento e caro. O SASE leva a segurança para perto do utilizador, em pontos de presença na cloud.

**Componentes.**

| Camada | Componentes |
|---|---|
| Rede | SD-WAN, otimização de WAN, acesso à internet/cloud com qualidade de serviço, DEM (monitorização da experiência) |
| Segurança | SWG, CASB, ZTNA, FWaaS, DLP, RBI (a Gartner agrupa estas funções sob SSE) |
| Entrega | Serviço cloud, política única, gestão centralizada, cliente/agente nos dispositivos |

---

## 3. O que é SSE

SSE é a parte de segurança do SASE: protege o acesso à web, a serviços cloud e a aplicações privadas, sem incluir SD-WAN. Segundo resumos públicos da definição da Gartner **[S]**, cobre proteção contra ameaças, segurança de dados, controlo de acesso, monitorização de segurança e controlo de utilização aceitável. O termo surge em 2021 (por exemplo no "Roadmap for SASE Convergence" e no Hype Cycle for Cloud Security 2021) **[S]**. É uma categoria de mercado definida pela Gartner, não uma norma.

### SASE vs SSE

| | SASE | SSE |
|---|---|---|
| O que é | Rede + segurança, entregues como serviço | Só a segurança |
| Inclui SD-WAN | Sim | Não |
| Inclui SWG, CASB, ZTNA, FWaaS, DLP | Sim | Sim |
| Quem compra tipicamente | Rede e segurança em conjunto | Equipa de segurança |
| Ano do termo (Gartner) | 2019 | 2021 |
| Cenário comum | Renovação de WAN/filiais | Substituir proxy, VPN e CASB isolados |

Nota de mercado **[S]**: a Gartner tem previsto que, até 2028, 50% das novas implementações SASE serão de plataforma de fornecedor único (30% em 2025), segundo imprensa que cita a Gartner. Não vi o relatório original.

---

## 4. Componentes em linguagem simples

| Sigla | O que faz | Substitui / complementa |
|---|---|---|
| **SWG** (Secure Web Gateway) | Filtra e inspeciona o tráfego web: bloqueia sites maliciosos, aplica políticas de utilização, inspeciona TLS. | Proxies web locais e appliances de filtragem |
| **CASB** (Cloud Access Security Broker) | Dá visibilidade e controlo sobre aplicações SaaS: quem usa o quê, que dados lá estão, configurações arriscadas. Funciona inline e por API. | Pouco existia antes; complementa DLP e proxy |
| **ZTNA** (Zero Trust Network Access) | Dá acesso a uma aplicação concreta (não à rede toda), após verificar identidade, dispositivo e contexto. | **VPN** de acesso remoto, que dá acesso amplo à rede |
| **FWaaS** (Firewall as a Service) | Firewall entregue na cloud, para tráfego que não é só web (portas e protocolos). | Firewalls de perímetro em filiais |
| **DLP** (Data Loss Prevention) | Deteta e impede a saída de dados sensíveis (cartões, dados pessoais, código) para web, SaaS, e-mail e apps de IA. | DLP de rede e de endpoint isolados |
| **RBI** (Remote Browser Isolation) | Abre sites de risco ou não categorizados num browser remoto; o utilizador só vê a imagem/renderização. | Bloqueio total de sites desconhecidos |
| **SD-WAN** | Liga filiais e sites escolhendo o melhor caminho (internet, MPLS, 5G) conforme a aplicação. | MPLS caro e routers WAN clássicos |
| **DEM** (Digital Experience Monitoring) | Mede a experiência real do utilizador (latência, falhas) de ponta a ponta, para saber se o problema é rede, aplicação ou dispositivo. | Ferramentas de monitorização separadas |

---

## 5. Como a Netskope endereça

Todos os factos abaixo são da Netskope ou de imprensa; as alegações de desempenho e de liderança são do fornecedor, não validação independente.

### 5.1 Plataforma
- **Netskope One** é o nome atual da plataforma. A página de produtos da Netskope lista Netskope One SSE, CASB, Next Gen SWG, Private Access (ZTNA), Cloud Firewall, SD-WAN e SkopeAI **[V parcial: via resultado de pesquisa da página de produtos; a página não carregou integralmente]**. A Netskope descreve o Next Gen SWG como a base da segurança inline de web e cloud, com proteção de ameaças e de dados.
- Um cliente unificado (Netskope One Client) consolida SSE (ZTNA, SWG, RBI, CASB), SD-WAN e DLP de endpoint **[S]** (imprensa).
- O nome anterior era "Intelligent SSE" (aparece nos comunicados de 2022-2023). Nomes e embalagem mudam; confirma sempre com a Netskope ou com o parceiro.

### 5.2 Rede privada: NewEdge
- NewEdge é a rede/cloud privada da Netskope onde correm os serviços inline. A empresa afirma ter datacenters com "full compute" e todos os serviços SSE disponíveis em cada um, acessíveis a todos os clientes sem custos adicionais (comunicado de fevereiro de 2022: mais de 50 regiões) **[V/S]**.
- Número mais recente que encontrei: comunicado de janeiro de 2024 com 205 Localization Zones e datacenters de computação completa em 72 regiões **[S]**. Pode estar desatualizado; **[NV]** o número em outubro de 2026.
- Afirma peering direto com grandes fornecedores web, cloud e SaaS **[S]**. É um argumento de desempenho do fornecedor, sem validação independente que eu tenha visto.

### 5.3 SD-WAN: Borderless SD-WAN (Infiot)
- A Netskope adquiriu a Infiot (anúncio a 2-3 de agosto de 2022; termos financeiros não divulgados). A tecnologia da Infiot (implantação cloud zero-touch, appliances físicos e virtuais, routing, QoE por aplicação, steering por política) tornou-se a base da então "Netskope Borderless WAN", hoje Borderless SD-WAN **[V]**. A equipa da Infiot integrou a Netskope.
- Com isto, a Netskope posiciona-se como fornecedor único de SASE (SSE + SD-WAN).

### 5.4 Proteção de dados
- A Netskope apresenta-se como "data-centric": DLP inline e por API, SkopeAI (classificadores de ML para dados não estruturados, coaching ao utilizador em tempo real) **[S]** (uma apresentação marca alguns pontos como roadmap; não consegui confirmar quais).
- **[NV]** Capacidades de DSPM: não encontrei confirmação em fonte primária.

### 5.5 IA generativa
- Página "Securing generative AI" da Netskope: controlo de ações em apps de IA (carregar, descarregar, copiar, imprimir), DLP aplicado a ChatGPT Enterprise, orientação dos utilizadores para ferramentas aprovadas (Copilot, ChatGPT Enterprise) **[V]**.
- A afirmação de que 72% do uso de IA generativa em empresas é "shadow AI" é da própria Netskope, não independente **[V como alegação; não como facto de mercado]**.

### 5.6 DEM
- Proactive DEM, lançado a 30 de agosto de 2023: sondas sintéticas + monitorização de utilizadores reais ("SMART"), abrangendo SSE, SD-WAN e NewEdge **[V/S]**. A documentação técnica (docs.netskope.com) descreve um âmbito mais restrito (latência, saúde da plataforma, experiência SaaS/web/privada). Verifica o âmbito atual antes de comparar.

### 5.7 Reconhecimento por analistas

| Relatório | Resultado | Fonte / estado |
|---|---|---|
| Gartner MQ for Security Service Edge | Leader desde a edição inaugural (2022); comunicado de 4 ago 2026: Leader pelo 5.º ano consecutivo | Comunicado sindicado **[S]**; não vi a página da Gartner |
| MQ SSE 2025 (publicado 20 mai 2025) | Posição "Furthest" em Completeness of Vision, segundo a Netskope | Página Netskope **[V como alegação]** |
| Gartner MQ for SASE Platforms (anteriormente "Single-Vendor SASE"), 9 jul 2025 | Leader | PDF de investidores + imprensa **[S]**; mudança de nome do relatório **[NV]** |
| Gartner Critical Capabilities (2025) | Imprensa indica pontuação mais alta em vários use cases (Foundational SASE, Zero Trust SASE, "Coffee Shop" networking) | **[S]** |

Aviso da própria Gartner: as classificações não são recomendação para escolher um fornecedor. Não afirmes posições exatas (por exemplo "mais alto em execução") sem confirmar o ano e o relatório. A posição da Palo Alto nos mesmos relatórios deve ser verificada separadamente antes de qualquer comparação.

---

## 6. Principais use cases

| # | Use case | Problema | Como o SSE/SASE resolve | Exemplo concreto |
|---|---|---|---|---|
| 1 | **Acesso remoto seguro / substituir a VPN** | A VPN dá acesso amplo à rede, é lenta e é alvo de ataques (movimento lateral). | ZTNA: acesso por aplicação, após verificar identidade e postura do dispositivo; a rede não fica exposta. | Um programador acede ao Git interno sem entrar na rede corporativa; um portátil sem disco cifrado perde o acesso. |
| 2 | **Shadow IT e controlo de SaaS** | Equipas usam centenas de apps SaaS que a TI não conhece. | CASB e SWG descobrem as apps, classificam o risco e permitem, bloqueiam ou limitam por ação. | Descobre-se um serviço de partilha de ficheiros pessoal; permite-se ver, bloqueia-se carregar ficheiros. |
| 3 | **Proteção de dados / DLP para SaaS** | Dados sensíveis saem por upload, partilha pública ou sincronização para contas pessoais. | DLP inline e por API, com políticas por instância (corporativa vs pessoal). | Bloquear upload de uma folha com NIFs para uma conta pessoal de cloud storage, mas permitir para a conta da empresa. |
| 4 | **Acesso web seguro e proteção contra ameaças** | Phishing, malware e sites maliciosos, com tráfego cifrado. | SWG com inspeção TLS, sandboxing, filtragem de URL; RBI para sites não categorizados. | Link de phishing numa campanha é aberto em browser isolado em vez de bloqueado ou permitido às cegas. |
| 5 | **Transformação de filiais** | MPLS caro, backhauling, muitos boxes por filial. | SD-WAN + SSE: ligação local à internet, segurança na cloud, política única. | Rede de lojas troca MPLS por SD-WAN com acesso à cloud seguro por SSE. |
| 6 | **Fusões e aquisições / terceiros** | Integrar rapidamente utilizadores externos sem juntar redes. | ZTNA sem agente (ou com agente leve) para dar acesso só às apps necessárias, sem VPN nem fusão de redes. | Após uma aquisição, 300 pessoas acedem a 5 apps internas sem interligar as redes. Subcontratado acede a uma só aplicação com sessão monitorizada. |
| 7 | **Governação de apps de GenAI** | Uso não gerido de IA generativa; risco de fuga de dados e de prompts. | Descobrir apps de IA, permitir as aprovadas, aplicar DLP aos prompts e uploads, coaching ao utilizador. | Permitir ChatGPT Enterprise; bloquear colar código-fonte ou dados de clientes em IA pública. |
| 8 | **Ligação à identidade** | O ZTNA só é tão bom quanto a identidade que verifica. | O SSE consome sinais do IdP (SSO, MFA, grupos, risco) e do endpoint para decidir o acesso, em cada pedido. | Acesso a uma app só com sessão do IdP, MFA recente e dispositivo gerido; sinal de risco de identidade revoga a sessão. |

Notas: a Netskope documenta integração com IdPs como Okta e Microsoft Entra; vi isto em resumos de terceiros e numa brochura da Okta **[S]**. Não consegui abrir a documentação oficial de configuração do Private Access.

---

## 7. Ligação à identidade (ponte para a Idira)

- **Humanos (IdP, MFA, IGA):** o SSE aplica políticas, mas depende do IdP para saber quem é o utilizador. Um IdP comprometido ou um token roubado enfraquece o ZTNA. O SSE não substitui a governação de acessos nem a deteção de ameaças à identidade (ITDR).
- **Acesso privilegiado (PAM):** o ZTNA decide se chegas à aplicação ou ao servidor; não gere credenciais privilegiadas, rotação, isolamento de sessão nem registo de sessões administrativas. É o espaço do PAM.
- **Identidades de máquina:** o tráfego de serviços, APIs e workloads (segredos, certificados, contas de serviço) é em geral outro problema e está fora do núcleo do SSE centrado em utilizadores. **[Inferência minha; não verifiquei se há cobertura parcial em algum produto Netskope.]**
- **Agentes de IA:** o SSE vê o tráfego e as ações em apps de IA (o que sai, para onde). Não responde, por si só, a que identidade o agente usa, que autoridade lhe foi delegada e com que permissões (MCP/ferramentas). **[Inferência minha.]**
- **Pergunta útil para a descoberta:** "Como decide hoje o vosso ZTNA/SSE que um acesso é legítimo, e o que acontece se a identidade por trás for uma conta privilegiada, uma conta de serviço ou um agente?"

Comparação com a Palo Alto: não verifiquei a oferta Prisma SASE nem como a Idira se integra nela; fazê-lo exige uma pesquisa à parte.

---

## 8. Glossário

| Sigla | Significado |
|---|---|
| SASE | Secure Access Service Edge |
| SSE | Security Service Edge |
| SWG | Secure Web Gateway |
| CASB | Cloud Access Security Broker |
| ZTNA | Zero Trust Network Access |
| FWaaS | Firewall as a Service |
| SD-WAN | Software-Defined Wide Area Network |
| DLP | Data Loss Prevention |
| RBI | Remote Browser Isolation |
| DEM | Digital Experience Monitoring/Management |
| SSPM | SaaS Security Posture Management |
| DSPM | Data Security Posture Management |
| IdP | Identity Provider |
| PAM | Privileged Access Management |
| IGA | Identity Governance and Administration |
| ITDR | Identity Threat Detection and Response |
| PoP | Point of Presence |
| QoE | Quality of Experience |
| MQ | Magic Quadrant (Gartner) |

---

## 9. Fontes (acedidas a 2026-10-19)

Definições (secundárias; o texto da Gartner está atrás de registo ou devolveu 403):
- Palo Alto Networks, "The Next Generation of Network Security Is Cloud-Delivered": https://paloaltonetworks.com/blog/?p=103028
- Cato Networks (reimpressão do relatório Gartner 2019): https://go.catonetworks.com/Gartner-The-Future-of-Network-Security-Is-in-the-Cloud.html
- Zscaler, nota sobre o relatório Gartner 2019: https://www.zscaler.com/jp/blogs/company-news/new-report-gartner-research-future-network-security-cloud
- SentinelOne, "What is SSE": https://www.sentinelone.com/cybersecurity-101/cloud-security/what-is-sse/
- Skyhigh Security, "What is SSE": https://www.skyhighsecurity.com/cybersecurity-defined/what-is-sse.html

Netskope (primárias):
- Produtos: https://www.netskope.com/products
- RBI: https://netskope.com/products/remote-browser-isolation
- Securing generative AI: https://www.netskope.com/products/securing-generative-ai
- Introducing Netskope Borderless SD-WAN: https://www.netskope.com/blog/introducing-netskope-borderless-wan
- Comunicado Infiot: https://www.netskope.com/de/press-releases/netskope-acquires-infiot-will-deliver-fully-integrated-single-vendor-sase-platform
- Comunicado NewEdge (2022): https://www.netskope.com/de/press-releases/netskope-global-coverage-and-connectedness-newedge-infrastructure
- Comunicado NewEdge (expansão): https://www.netskope.com/fr/press-releases/netskope-newedge-expansion-continues-to-enable-unprecedented-network-and-security-transformation
- Proactive DEM (comunicado): https://www.netskope.com/jp/press-releases/netskope-delivers-the-next-evolution-in-digital-experience-management-for-sase-with-proactive-dem
- Proactive DEM (documentação): https://docs.netskope.com/en/digital-experience-management.html
- Relações com investidores (PDF com referências Gartner de 2025): https://investors.netskope.com/node/6626/pdf
- Blog SSE/SASE Leader: https://www.netskope.com/jp/blog/a-leader-in-both-security-service-edge-and-single-vendor-sase

Imprensa e terceiros (secundárias):
- Help Net Security, Infiot (3 ago 2022): https://www.helpnetsecurity.com/2022/08/03/netskope-infiot/
- SC Media, Infiot: https://www.scmagazine.com/brief/netskope-buys-infiot-for-borderless-wan-technology
- Comunicado MQ SSE, 5.º ano (via Barchart, 2026): https://www.barchart.com/story/news/3640301/netskope-named-a-leader-in-the-gartner-magic-quadrant-for-security-service-edge-for-5th-year-in-a-row
- SecurityBrief, Netskope Leader em MQ SASE: https://securitybrief.co.uk/story/netskope-named-leader-in-gartner-sase-magic-quadrant-again
- SecurityBrief, Leader SASE/SSE: https://securitybrief.co.uk/story/netskope-named-leader-in-sase-sse-by-major-industry-analysts
- IT Brief, Netskope One (IA e dados): https://itbrief.co.uk/story/netskope-one-upgrades-boost-ai-data-protection-visibility
- Help Net Security, Proactive DEM: https://www.helpnetsecurity.com/2023/08/30/netskope-proactive-dem/
- Okta + Netskope (brochura): https://www.okta.com/sites/default/files/2024-02/Okta%20%2B%20Netskope%20Solution%20Brief.pdf

Normas de referência (não consultadas diretamente nesta pesquisa): NIST SP 800-207 (Zero Trust Architecture).

## Lacunas

- Texto original da Gartner (SASE 2019, SSE 2021, MQ): não acedido.
- Números atuais da NewEdge (2026) e embalagem/licenciamento da Netskope One: não confirmados.
- Capacidades de DSPM, SSPM e documentação oficial do Private Access com IdPs: não confirmadas.
- Posição da Palo Alto (Prisma SASE) nos MQ e comparação direta: fora do âmbito, por fazer.
