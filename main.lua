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

function tabuleiro:constroiTabuleiro()

	for i = 1, 10 do
	
		for j = 1, 10 do

			self[i][j] = 0

		end
	end

	return self

end

local navios = {
	navioTamanho2 = {tamanho = 2, orientacao = {"vertical", "horizontal"}},
	navioTamanho3 = {tamanho = 3, orientacao = {"vertical", "horizontal"}},
	navioTamanho4 = {tamanho = 4, orientacao = {"vertical", "horizontal"}},
	navioTamanho5 = {tamanho = 5, orientacao = {"vertical", "horizontal"}}
}

local jogador1 = {
	nome = "Player 1",
	mapa = tabuleiro:constroiTabuleiro(),
	pontuacao = 0,
	naviosDoJogador = navios
}

function tabuleiro:existe(tabuleiro)
	for i = 1, #tabuleiro do
		for j = 1, #tabuleiro[i] do
			if(tabuleiro[i][j] == 0) then
				return true
			else 
				return false
			end
		end
	end
end

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

function inserirNavio(argJogador, argLinha, argColuna, argNavio, argOrientacao)
	local mapa = argJogador.mapa

	--if (argNavio.tamanho == 0) then

		if (argNavio.orientacao[argOrientacao] == "vertical") then

			for i = 0, argNavio.tamanho - 1 do
				mapa[argLinha + i][argColuna] = argNavio.tamanho
			end

		elseif (argNavio.orientacao[argOrientacao] == "horizontal") then

			for i = 0, argNavio.tamanho - 1 do
				mapa[argLinha][argColuna + i] = argNavio.tamanho
			end
		end

	--	argNavio.tamanho = 0

	--else 
	--	print("navio ja adicionado")
	--end

	return mapa

end

function mostrarMapa(mapa)

	if(tabuleiro:existe(mapa) ~= nil) then 
		mapa = tabuleiro:constroiTabuleiro()
	end

	return tabuleiro:toString(mapa)
end

jogador1.mapa = inserirNavio(jogador1, 1, 2, navios.navioTamanho4, 2)

--jogador1.mapa = inserirNavio(jogador1, 2, 2, navios.navioTamanho4, 1)

print (tabuleiro:toString(jogador1.mapa))

--jogador1.naviosDoJogador.navioTamanho4 = nil

for k, v in pairs(jogador1.naviosDoJogador) do
	print (k, v)
end