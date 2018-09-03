----- Tabuleiros ------
local tabuleiroJogador1 = {
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
}

local tabuleiroJogador2 = {
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
}

------- Mapa de visão do inimigo -------

local mapaJogador1 = {
	{"?","?","?","?","?","?","?","?","?","?",},
	{"?","?","?","?","?","?","?","?","?","?",},
	{"?","?","?","?","?","?","?","?","?","?",},
	{"?","?","?","?","?","?","?","?","?","?",},
	{"?","?","?","?","?","?","?","?","?","?",},
	{"?","?","?","?","?","?","?","?","?","?",},
	{"?","?","?","?","?","?","?","?","?","?",},
	{"?","?","?","?","?","?","?","?","?","?",},
	{"?","?","?","?","?","?","?","?","?","?",},
	{"?","?","?","?","?","?","?","?","?","?",},
} 

local mapaJogador2 = {
	{"?","?","?","?","?","?","?","?","?","?"},
	{"?","?","?","?","?","?","?","?","?","?"},
	{"?","?","?","?","?","?","?","?","?","?"},
	{"?","?","?","?","?","?","?","?","?","?"},
	{"?","?","?","?","?","?","?","?","?","?"},
	{"?","?","?","?","?","?","?","?","?","?"},
	{"?","?","?","?","?","?","?","?","?","?"},
	{"?","?","?","?","?","?","?","?","?","?"},
	{"?","?","?","?","?","?","?","?","?","?"},
	{"?","?","?","?","?","?","?","?","?","?"},
} 

----- Funções -----------
function preencherTabuleiro(tabuleiro)
	for i=1,10 do
		for j=1,10 do
			tabuleiro[i][j] = 0
		end
	end
end

function viewTabuleiro(tabuleiro)
	local strTabuleiro = ""
	for i=1, #tabuleiro do
		for j=1, #tabuleiro[i] do
			strTabuleiro = strTabuleiro .. tabuleiro[i][j]
		end
			strTabuleiro = strTabuleiro .. "\n"
	end

	return strTabuleiro

end 

function inserirNavio(jogador, linha, coluna, opcao, orientacao, tamanhoTotalDosBarcos, naviosRestantes)
local posicaoOk = false

for k,v in pairs(jogador.totalNavios) do
		
	if opcao == v.tamanho then
		opcao = v
		posicaoOk = true
		opcao.orientacao = orientacao

		if opcao.orientacao == "vertical" then
			for i = opcao.tamanho, 1, -1 do
				if jogador.tabuleiro[linha + (i - opcao.tamanho)][coluna] ~= 0 then
					posicaoOk = false
				end
			end
		else 
			for i=0, opcao.tamanho -1, 1 do
				if jogador.tabuleiro[linha][coluna + i] ~=  0 then
					posicaoOk = false
				end
			end
		end
	end
end

	if posicaoOk == true then
		if opcao.orientacao == "vertical" then
			for i = opcao.tamanho, 1, -1 do
				jogador.tabuleiro[linha + (i - opcao.tamanho)][coluna] = opcao.tamanho
			end
			naviosRestantes = naviosRestantes - 1
			tamanhoTotalDosBarcos = tamanhoTotalDosBarcos + opcao.tamanho
			print("\nNavio inserido!\n")
			return tamanhoTotalDosBarcos, naviosRestantes
		else
			for i=0, opcao.tamanho -1, 1 do
				jogador.tabuleiro[linha][coluna + i] = opcao.tamanho
			end
			naviosRestantes = naviosRestantes - 1

			tamanhoTotalDosBarcos = tamanhoTotalDosBarcos + opcao.tamanho
			print("\nNavio inserido!\n")
			return tamanhoTotalDosBarcos, naviosRestantes
		end

	else
		print("\nErro ao inserir navio! Verifique o tamanho e a posicao!\n")
		return tamanhoTotalDosBarcos, naviosRestantes
	end

end

function atirarNoTabuleiro(tabuleiro, mapa, linha, coluna, pontuacao)
	for i=1, #tabuleiro[linha] do
		if tabuleiro[linha][coluna] ~= 0 then
			mapa[linha][coluna] = "X"
			tabuleiro[linha][coluna] = 0
			return true, pontuacao + 1
		end
	end
	return false, pontuacao
end

---------------- Navios ----------------

local navios = {
	Corveta = {tamanho = 2, orientacao = "vertical"},
	Fragata = {tamanho = 3, orientacao = "vertical"},
	PortaAvioes = {tamanho = 4, orientacao = "vertical"},
	Cruzador = {tamanho = 5, orientacao = "vertical"}
}

-----------------  Jogadores ----------------

local jogador1 = {
	nome = "Player 1",
	tabuleiro = tabuleiroJogador1,
	mapa = mapaJogador1,
	pontuacao = 0,
	totalNavios = navios
}


local jogador2 = {
	nome = "Player 2",
	tabuleiro = tabuleiroJogador2,
	mapa = mapaJogador2,
	pontuacao = 0,
	totalNavios = navios
}

preencherTabuleiro(jogador1.tabuleiro)
preencherTabuleiro(jogador2.tabuleiro)

--------- Inserir Navios do Jogador 1 --------

print("--------- Player 1  inserir Navios -----\n\n")
local naviosRestantes = 4
local tamanhoTotalDosBarcos1 = 0

repeat
local opcao, orientacao
local x, y

	print("Digite o tamanho do navio \n 2. Corveta \n 3. Fragata \n 4. PortaAvioes\n 5. Cruzador\n 0 para sair")
	opcao = io.read("*n")

	if opcao == 0 then return end

	print("Posição X no tabuleiro")
	x = io.read("*n")

	print("Posição Y no tabuleiro")
	y = io.read("*n")

	print("vertical || horizontal")
	io.read()
	orientacao = io.read()

 	tamanhoTotalDosBarcos1, naviosRestantes = inserirNavio(jogador1, x, y, opcao, orientacao, tamanhoTotalDosBarcos1, naviosRestantes)
 	print(naviosRestantes)
	print(viewTabuleiro(jogador1.tabuleiro))

until (opcao == 0 or naviosRestantes == 0)

----- Navios do Jogador 2 ----
print("\n\n--------- Player 2  inserir Navios ----- \n\n")
naviosRestantes = 4
tamanhoTotalDosBarcos2 = 0

repeat

	print("Digite o tamanho do navio \n 2. Corveta \n 3. Fragata \n 4. PortaAvioes\n 5. Cruzador\n 0 para sair")
	opcao = io.read("*n")

	if opcao == 0 then return end

	print("Posição X no tabuleiro")
	x = io.read("*n")

	print("Posição Y no tabuleiro")
	y = io.read("*n")

	print("vertical || horizontal")
	io.read()
	orientacao = io.read()
		
	tamanhoTotalDosBarcos2, naviosRestantes = inserirNavio(jogador2, x, y, opcao, orientacao, tamanhoTotalDosBarcos2, naviosRestantes)

	print(viewTabuleiro(jogador2.tabuleiro))

until (opcao == 0 or naviosRestantes == 0)

local vezPlayer1 = false
local vezPlayer2 = false

repeat
 ----------- GAME ------------
	print("\n\n----Jogador 1 é sua vez -----\n\n" .. viewTabuleiro(jogador2.mapa))

	print("\nPosição X no tabuleiro")
	x = io.read("*n")

	print("Posição Y no tabuleiro")
	y = io.read("*n")

	vezPlayer1, jogador1.pontuacao = atirarNoTabuleiro(tabuleiroJogador2, jogador2.mapa, x, y, jogador1.pontuacao)

	print("\n" .. viewTabuleiro(jogador2.mapa))

	while vezPlayer1 == true do

		if jogador1.pontuacao == tamanhoTotalDosBarcos1 then 
			print("Vencedor " .. jogador1.nome)
		return end

		print("Jogue mais uma vez! \n".. viewTabuleiro(jogador2.mapa))

		print("\nPosição X no tabuleiro")	
		x = io.read("*n")

		print("Posição Y no tabuleiro")
		y = io.read("*n")

		vezPlayer1, jogador1.pontuacao = atirarNoTabuleiro(tabuleiroJogador2, jogador2.mapa, x, y, jogador1.pontuacao)

	end

	print("\n\n----Jogador 2 é sua vez -----\n\n" .. viewTabuleiro(jogador1.mapa))

	print("\nPosição X no tabuleiro")
	x = io.read("*n")

	print("Posição Y no tabuleiro")
	y = io.read("*n")

	vezPlayer2, jogador2.pontuacao = atirarNoTabuleiro(tabuleiroJogador1, jogador1.mapa, x, y, jogador2.pontuacao)

	print("\n" .. viewTabuleiro(jogador1.mapa))

	while vezPlayer2 == true do

		if jogador2.pontuacao == tamanhoTotalDosBarcos2 then
			print("Vencedor " .. jogador2.nome)
		return end

		print("Jogue mais uma vez! \n".. viewTabuleiro(jogador1.mapa))

		print("\nPosição X no tabuleiro")
		x = io.read("*n")

		print("Posição Y no tabuleiro")
		y = io.read("*n")

		vezPlayer2, jogador2.pontuacao = atirarNoTabuleiro(tabuleiroJogador1, jogador1.mapa, x, y, jogador2.pontuacao)

	end

until jogador1.pontuacao == tamanhoTotalDosBarcos1 or jogador2.pontuacao == tamanhoTotalDosBarcos2