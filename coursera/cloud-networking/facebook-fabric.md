um pod é uma "unidade de rede"
1 pod tem 4 "fabric switches", com uplink de 40G cada (160G no total);
abaixo desses tem 48 "top of rack switches", ou seja cada pod tem 48 racks;
4 planos (spine plans) com 48 switches em cada

permite centenas de milhares de servidores com NIC de 10G
com multi petabit de banda e
sem oversubscription

pra conectividade externa existem edge pods com 7.68Tbps de banda

framework modular e uniforme

para mais poder computacional, adiciona server pods
para mais capacidade de rede, adiciona switches nos spine plans
para mais conectividade, adiciona edge pods ou escala os uplinks

começaram a construção "top down"
BGP4 como único protocolo de roteamento
controller BGP centralizado para override de rotas (distributed control, centralized override)
tudo em layer3
tudo com IPv4 e IPv6
uso pesado de ECMP (equal-cost multi-path)

mecanismo robusto para deploy automático de configurações
alertas com prioridade
auto-resolução
push buttons para tirar/colocar qualquer dispositivo em produção

problemas conhecidos são automaticamente resolvidos e alertados
problemas desconhecidos devem gerar automação para a solução automática nas próximas ocorrências

retrocompatibilidade e transição transparente

apesar de complexa e de larga escala, a operação é simples por conta de design e automação

https://code.facebook.com/posts/360346274145943/introducing-data-center-fabric-the-next-generation-facebook-data-center-network
