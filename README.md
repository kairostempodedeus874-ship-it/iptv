# Servidor de WhatsApp — NexPlay

Este pacote conecta o seu número de WhatsApp ao painel NexPlay por QR Code.
Ele recebe as mensagens, envia para o robô de IA do painel e devolve a resposta ao cliente.

## O que tem no pacote

| Arquivo | Para que serve |
|---|---|
| `server.js` | o servidor (QR Code, status, envio e recebimento) |
| `package.json` | o que o servidor precisa para funcionar |
| `Dockerfile` | receita de instalação usada pelo Render |
| `render.yaml` | configura o Render sozinho (plano Starter + disco) |
| `.dockerignore` / `.gitignore` | arquivos que não devem subir |

Todos os arquivos ficam na **raiz** do repositório — não crie subpasta.

---

## Parte 1 — Subir no GitHub

1. Acesse github.com e clique em **New repository**.
2. Dê um nome, por exemplo `nexplay-whatsapp`, marque **Private** e clique em **Create repository**.
3. Clique em **Add file → Upload files**.
4. Arraste **todos** os arquivos deste pacote.
5. Confirme que `package.json`, `Dockerfile` e `render.yaml` aparecem na tela principal do repositório.
6. Clique em **Commit changes**.

> Os arquivos que começam com ponto (`.dockerignore` e `.gitignore`) podem ser criados pelo botão
> **Add file → Create new file**, digitando o nome exato.

---

## Parte 2 — Subir no Render

1. Acesse render.com e entre com a conta do GitHub.
2. Clique em **New → Blueprint**.
3. Escolha o repositório criado.
4. Confira apenas dois pontos:
   - **Plano: Starter** (o plano Free dorme e não tem disco, então a sessão do WhatsApp se perde).
   - **Disco montado em `/var/data`**.
5. Clique em **Apply** e espere o deploy ficar **Live** (3 a 8 minutos).
6. Copie o endereço mostrado no topo, algo como `https://nexplay-whatsapp.onrender.com`.

---

## Parte 3 — Testar antes de conectar

Abra no navegador:

```
https://SEU-ENDERECO.onrender.com/api/diagnostico
```

O ideal é ver:

- `"ok": true`
- `"pasta_persistente": true`
- `"permissoes_banco": "completa"`

Se aparecer algo na lista `problemas`, leia a mensagem — quase sempre é o disco fora de `/var/data`.

---

## Parte 4 — Conectar no painel

1. Abra a aba **WhatsApp** no painel.
2. Cole o endereço do servidor e clique em **Salvar**.
3. Clique em **Testar servidor**.
4. Clique em **Gerar QR Code** e leia no celular em *WhatsApp → Dispositivos conectados → Conectar dispositivo*.
5. Quando conectar, a tela mostra o número e o nome do perfil.

---

## Rotas disponíveis

| Rota | Método | Função |
|---|---|---|
| `/api/diagnostico` | GET | verifica se está tudo certo |
| `/api/status` | GET | conexão, número, nome e QR |
| `/api/conectar` | POST | inicia a conexão e devolve o QR Code |
| `/api/qr` | GET | devolve o QR Code atual |
| `/api/desconectar` | POST | desconecta e apaga a sessão |
| `/api/enviar` | POST | envia mensagem (`numero` e `mensagem`) |
| `/api/agente` | POST | repassa uma consulta ao robô do painel |

---

## Avisos importantes

- Depois do primeiro QR Code lido, a sessão fica salva no disco e o servidor reconecta sozinho.
- Não troque o plano para Free: ele dorme e perde a sessão.
- Mantenha o endereço do serviço em sigilo — é o controle do seu WhatsApp.
- A IA só responde se a chave da OpenAI estiver cadastrada no painel. Sem ela, as mensagens chegam e ficam aguardando você.