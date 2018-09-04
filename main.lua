----------------------Construir Tabuleiro---------------------------
function constroiTabuleiro(preenchimento)

	local tabuleiroCriado = {
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{},
		{}
	}

	for i = 1, 10 do
	
		for j = 1, 10 do

			tabuleiroCriado[i][j] = preenchimento

		end
	end

	return tabuleiroCriado

end
---------------------------------------------------------------------------
-------------------------------Gerar Navios--------------------------------
function gerarNavios()
	local navios = {
		Rebocador = {tamanho = 2, orientacao = {"vertical", "horizontal"}},
		Contratorpedo = {tamanho = 3, orientacao = {"vertical", "horizontal"}},
		Cruzador = {tamanho = 4, orientacao = {"vertical", "horizontal"}},
		PortaAvioes = {tamanho = 5, orientacao = {"vertical", "horizontal"}}
	}

	return navios

end


local jogador1 = {
	nome = "Player 1",
	mapa = constroiTabuleiro(0),
	mapaDoAdversario = constroiTabuleiro("?"),
	pontuacao = 0,
	naviosDoJogador = gerarNavios()
}

local jogador2 = {
	nome = "Player 2",
	mapa = constroiTabuleiro(0),
	mapaDoAdversario = constroiTabuleiro("?"),
	pontuacao = 0,
	naviosDoJogador = gerarNavios()
}

function toString(argTabuleiro)
	local strTabuleiro = ""
	local tabuleiro = argTabuleiro
	
	for i = 1, #tabuleiro do
		for j = 1, #tabuleiro[i] do
			strTabuleiro = strTabuleiro .. tabuleiro[i][j]
		end
		strTabuleiro = strTabuleiro .."\n"
	end
	return strTabuleiro
end

function quantidadeDeNavios(argJogador)
	argJogador.quantidadeNavios = 0
	for k, v in pairs(argJogador.naviosDoJogador) do
		if(v.tamanho ~= 0) then
			argJogador.quantidadeNavios = argJogador.quantidadeNavios + 1
			print (k, "|"..v.tamanho)
		end
	end
	return argJogador.quantidadeNavios
end

function podeInserir(argMapa, argLinha, argColuna, argNavio, argOrientacao)
	if(argNavio.tamanho == 0) then 
		print("Navio ja adicionado")
		return false 
	end

	if (argNavio.orientacao[argOrientacao] == "vertical") then

		for i = 0, argNavio.tamanho - 1 do
			if (argMapa[argLinha + i][argColuna] ~= 0) then
				print("Colisao com outro navio")
				return false
			end
		end
	elseif (argNavio.orientacao[argOrientacao] == "horizontal") then

		for i = 0, argNavio.tamanho - 1 do
			if(argMapa[argLinha][argColuna + i] ~= 0) then
				print("Colisao com outro navio")
				return false
			end
		end
	end

	return true

end

------------------------------posiciona o Navio no mapa--------------------------------

function inserirNavio(argJogador, argLinha, argColuna, argNavio, argOrientacao)
	local mapa = argJogador.mapa
	
	if (argNavio.orientacao[argOrientacao] == "vertical") then

		for i = 0, argNavio.tamanho - 1 do
			mapa[argLinha + i][argColuna] = argNavio.tamanho
		end

	elseif (argNavio.orientacao[argOrientacao] == "horizontal") then

		for i = 0, argNavio.tamanho - 1 do
			mapa[argLinha][argColuna + i] = argNavio.tamanho
		end
	end

	argNavio.tamanho = 0

	return mapa

end

function ganhar(argJogadorDaVez)
	local naviosPadroes = gerarNavios()
	local somatorio = 0
	for k, v in pairs(naviosPadroes) do
		somatorio = somatorio + v.tamanho
	end

	if(argJogadorDaVez.pontuacao == somatorio) then
		return true
	else
		return false
	end
end
----------------------------------------------------------------------------------------
function acertar(argJogadorAtirador, argJogadorAlvo, argLinha, argColuna)
	local aux = argJogadorAlvo.mapa[argLinha][argColuna]
	if (aux ~= "X") then
		argJogadorAtirador.mapaDoAdversario[argLinha][argColuna] = aux
	end
	if(aux ~= 0 and aux ~= "X") then
		argJogadorAlvo.mapa[argLinha][argColuna] = "X"
		argJogadorAtirador.pontuacao = argJogadorAtirador.pontuacao + 1
		return true
	else 
		return false
	end
end

function mostrarNavioSelecionado(argumento)
	print ("--------------------------------------------")
	print ("Navio Selecionado: "..argumento)
	print ("--------------------------------------------")
end
-------------------------------------------------------------------------------------
function vezInserirNavio(argJogador)
	repeat

		print ("Mapa do Jogador: " ..argJogador.nome.."\n")
		print (toString(argJogador.mapa))
		print ("Navios Disponiveis\n")

		print ("  Navio     	|Tamanho")
		print ("________________________")

		if(quantidadeDeNavios(argJogador) == 0) then break end

	------------------------------SELECIONA O NAVIO ---------------------------------
		print("\nSelecione o tamanho do navio para inserir\n"
			.."0 Para sair")
		navioEscolhido = io.read("*n")

		if navioEscolhido == 0 then break end

		for k, v in pairs(argJogador.naviosDoJogador) do

			if(navioEscolhido == v.tamanho) then
				navioEscolhido = v
				mostrarNavioSelecionado(k)
			end
		end
	---------------------------------------------------------------------------------

		print ("\nSelecione a Linha: 1 - 10")
		posicaoX = io.read("*n")

		print ("\nSelecione a Coluna: 1 - 10")
		posicaoY = io.read("*n")

		print ("\nSelecione a orientacao do navio: 1 = vertical, 2 = horizontal")
		orientacaoDoNavio = io.read("*n")

		if(podeInserir(argJogador.mapa, posicaoX, posicaoY, navioEscolhido, orientacaoDoNavio) == true) then 
			argJogador.mapa = inserirNavio (argJogador, posicaoX, posicaoY, navioEscolhido, orientacaoDoNavio)
		end
	until (navioEscolhido == 0 or argJogador.quantidadeNavios == 0)
end

function trocaVez(argJogadorDaVez, argJogadorOponente)
	return argJogadorOponente, argJogadorDaVez
end
-----------------------------------------JOGO----------------------------------------
local posicaoX, posicaoY
local navioEscolhido
local orientacaoDoNavio
local inseriuNavio
-----------------------------inserção Navio Jogador 1--------------------------------
vezInserirNavio(jogador1)
-------------------------------insersao jogador 2--------------------------------
vezInserirNavio(jogador2)
-----------------------------------Tiros-----------------------------------------
local jogadorDaVez = jogador1
local jogadorOponente = jogador2
local acertou, ganhou
print ("----------------------------------------------------------------------")
print ("QUE COMECE A TROCACAO")
print ("----------------------------------------------------------------------")

repeat
	print ("Vez do Jogador: " .. jogadorDaVez.nome)
	repeat
		print ("\nSelecione a Linha: 1 - 10")
		posicaoX = io.read("*n")

		print ("\nSelecione a Coluna: 1 - 10")
		posicaoY = io.read("*n")

		if(acertar(jogadorDaVez, jogadorOponente, posicaoX, posicaoY) == true) then
			acertou = true
			if(ganhar(jogadorDaVez) == true) then
				ganhou = true
				break
			end
		else
			jogadorDaVez, jogadorOponente = trocaVez(jogadorDaVez, jogadorOponente)
			acertou = false
		end

		print ("Mapa da Visao: ")
		print (toString(jogadorDaVez.mapaDoAdversario))

	until(acertou == false)

until(ganhou == true)
print("Vencedor: " ..jogadorDaVez.nome.. "\nPontuacao: " ..jogadorDaVez.pontuacao * 10)