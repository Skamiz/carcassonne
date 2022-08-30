
local tilesheet = {
	image = "csn_tb_tilesheet.png",
	width = 6,
	height = 4,
}

local card_defs = {
	{description = "CCCC", amount = 1},
	{description = "CCCC", amount = 1},
	{description = "CCCF", amount = 1},
	{description = "CCCF", amount = 1},
	{description = "CCCF", amount = 1},
	{description = "CCCR", amount = 1},
	{description = "CCCR", amount = 1},
	{description = "CCCR", amount = 1},
	{description = "CCFF", amount = 1},
	{description = "CCFF", amount = 1},
	{description = "CCFR", amount = 1},
	{description = "CCFR", amount = 1},
	{description = "CCRF", amount = 1},
	{description = "CCRF", amount = 1},
	{description = "CCRR", amount = 1},
	{description = "CCRR", amount = 1},
	{description = "CFCF", amount = 1},
	{description = "CFCR", amount = 1},
	{description = "CFCR", amount = 1},
	{description = "CFRR", amount = 1},
	{description = "CRCR", amount = 1},
	{description = "CRFF", amount = 1},
	{description = "FRRR", amount = 1},
	{description = "RRRR", amount = 1},

}

local deck = tile_cards.deck_from_tilesheet(tilesheet, card_defs)


for _, v in pairs(deck) do
	tile_cards.master_deck[#tile_cards.master_deck + 1] = v
end
