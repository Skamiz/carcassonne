
local tilesheet = {
	image = "csn_ic_tilesheet.png",
	width = 4,
	height = 5,
}

local card_defs = {
	{description = "CCCC", amount = 1},
	{description = "Cathedral", amount = 2},
	{description = "CCCF", amount = 1},
	{description = "CCCF", amount = 1},
	{description = "CCFR", amount = 1},
	{description = "CCRF", amount = 1},
	{description = "CCRR", amount = 1},
	{description = "CFFF", amount = 1},
	{description = "CFRF", amount = 1},
	{description = "CFRR", amount = 1},
	{description = "CRCR", amount = 1},
	{description = "CRCR", amount = 1},
	{description = "FFRR", amount = 1},
	{description = "FRFR", amount = 1},
	{description = "FRFR", amount = 1},
	{description = "FRRR", amount = 1},
	{description = "RRRR", amount = 1},
}

local deck = tile_cards.deck_from_tilesheet(tilesheet, card_defs)


for _, v in pairs(deck) do
	tile_cards.master_deck[#tile_cards.master_deck + 1] = v
end
