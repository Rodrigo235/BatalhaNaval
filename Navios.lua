local navios = {
	navioTamanho2 = {tamanho = 2, orientacao = "vertical"},
	navioTamanho3 = {tamanho = 3, orientacao = "vertical"},
	navioTamanho4 = {tamanho = 4, orientacao = "vertical"},
	navioTamanho5 = {tamanho = 5, orientacao = "vertical"}
}

navios["navioTamanho4"] = nil




for k, v in pairs(navios) do
	print (k, v)
end