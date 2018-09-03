local tabuleiro = {
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



function tabuleiro:constroiTabuleiro(preenchimento)

	local tabuleiroCriado = tabuleiro

	for i = 1, 10 do
	
		for j = 1, 10 do

			tabuleiroCriado[i][j] = preenchimento

		end
	end

	return tabuleiroCriado

end

local navios = {
	Rebocador = {tamanho = 2, orientacao = {"vertical", "horizontal"}},
	Contratorpedo = {tamanho = 3, orientacao = {"vertical", "horizontal"}},
	Cruzador = {tamanho = 4, orientacao = {"vertical", "horizontal"}},
	PortaAvioes = {tamanho = 5, orientacao = {"vertical", "horizontal"}}
}

local jogador1 = {
	nome = "Player 1",
	mapa = tabuleiro:constroiTabuleiro(0),
	--mapaDoAdversario = tabuleiro:constroiTabuleiro("?"),
	pontuacao = 0,
	naviosDoJogador = navios
}

function tabuleiro:toString(argTabuleiro)
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

function acertar(argMapaDoAdversario, argLinha, argColuna)
	if(argMapaDoAdversario[argLinha][argColuna] ~= 0) then
		return true
	else 
		retturn false
	end
end

function atirar(argMapaDoAdversario, argLinha, argColuna)
	argMapaDoAdversario[argLinha][argColuna] = "X"
end


-------------------------------------------------------------------------------------
function mostrarNavioSelecionado(argumento)
	print ("--------------------------------------------")
	print ("Navio Selecionado: "..argumento)
	print ("--------------------------------------------")
end
-----------------------------------------JOGO------------------------------------------
local posicaoX, posicaoY
local navioEscolhido
local orientacaoDoNavio
local inseriuNavio

repeat

	print ("Mapa do Jogador: " ..jogador1.nome.."\n")
	print (tabuleiro:toString(jogador1.mapa))
	print ("Navios Disponiveis\n")

	print ("  Navio     	|Tamanho")
	print ("________________________")

	jogador1.quantidadeNavios = 0
	for k, v in pairs(jogador1.naviosDoJogador) do
		if(v.tamanho ~= 0) then
			jogador1.quantidadeNavios = jogador1.quantidadeNavios + 1
			print (k, "|"..v.tamanho)
		end
	end
	if(jogador1.quantidadeNavios == 0) then break end

------------------------------SELECIONA O NAVIO ---------------------------------
	print("\nSelecione o tamanho do navio para inserir\n"
		.."0 Para sair")
	navioEscolhido = io.read("*n")

	if navioEscolhido == 0 then break end

	for k, v in pairs(jogador1.naviosDoJogador) do

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

	if(podeInserir(jogador1.mapa, posicaoX, posicaoY, navioEscolhido, orientacaoDoNavio) == true) then 
		jogador1.mapa = inserirNavio (jogador1, posicaoX, posicaoY, navioEscolhido, orientacaoDoNavio)
	end

until (navioEscolhido == 0 or jogador1.quantidadeNavios == 0)

-----------------------------------Tiros-----------------------------------------
