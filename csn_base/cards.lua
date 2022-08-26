
local tilesheet = {
	image = "csn_base_tilesheet.png",
	width = 5,
	height = 5,
}

local card_defs = {
	{description = "CCCC", amount = 1},
	{description = "CCCF", amount = 3},
	{description = "CCCF", amount = 1},
	{description = "CCCR", amount = 2},
	{description = "CCCR", amount = 1},
	{description = "CCFF", amount = 3},
	{description = "CCFF", amount = 2},
	{description = "CCFF", amount = 2},
	{description = "CCRR", amount = 3},
	{description = "CCRR", amount = 2},
	{description = "CFCF", amount = 3},
	{description = "CFCF", amount = 2},
	{description = "CFCF", amount = 1},
	{description = "CFFF", amount = 5},
	{description = "CFRR", amount = 3},
	{description = "CRFR", amount = 3},
	{description = "CRRF", amount = 3},
	{description = "CRRR", amount = 3},
	{description = "FFFF", amount = 4},
	{description = "FFFR", amount = 2},
	{description = "FFRR", amount = 9},
	{description = "FRFR", amount = 8},
	{description = "FRRR", amount = 4},
	{description = "RRRR", amount = 1},
	{description = "CRFR", amount = 1},
}

local deck = tile_cards.deck_from_tilesheet(tilesheet, card_defs)


for _, v in pairs(deck) do
	tile_cards.master_deck[#tile_cards.master_deck + 1] = v
end
