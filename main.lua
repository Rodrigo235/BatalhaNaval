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

local jogador = {
	mapa = tabuleiro,
	pontuacao = 0
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

function tabuleiro:constroiTabuleiro()

	for i = 1, 10 do
	
		for j = 1, 10 do

		tabuleiro[i][j] = 0

		end
	end

	return tabuleiro

end

function tabuleiro:toString(tabuleiroArg)
	local strTabuleiro = ""
	local tabuleiro = tabuleiroArg
	
	for i = 1, #tabuleiro do
		for j = 1, #tabuleiro[i] do
			strTabuleiro = strTabuleiro .. tabuleiro[i][j]
		end
		strTabuleiro = strTabuleiro .."\n"
	end
	return strTabuleiro
end

function mostrarTabuleiro()

	if(tabuleiro:existe(tabuleiro) ~= true) then 
		tabuleiro:constroiTabuleiro()
	end

	return tabuleiro:toString(tabuleiro)
end

local navios = {
	navioTamanho2 = {tamanho = 2, orientacao = "vertical"},
	navioTamanho3 = {tamanho = 3, orientacao = "vertical"},
	navioTamanho4 = {tamanho = 4, orientacao = "vertical"},
	navioTamanho5 = {tamanho = 5, orientacao = "vertical"}
}

function preencherMapa(tabuleiro, linha, coluna, navio)
	-- body
end

print (mostrarTabuleiro())