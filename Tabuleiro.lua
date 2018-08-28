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
end

function tabuleiro:toString(tabuleiro)
	local strTabuleiro = ""

	for i = 1, #tabuleiro do
		for j = 1, #tabuleiro[i] do
			strTabuleiro = strTabuleiro .. tabuleiro[i][j]
		end
		strTabuleiro = strTabuleiro .."\n"
	end
	return strTabuleiro
end