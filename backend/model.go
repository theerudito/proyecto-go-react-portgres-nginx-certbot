package main

type character struct {
	Character_Id int    `json:"character_id"`
	Name         string `json:"name"`
	Age          int    `json:"age"`
	Clan_Name    string `json:"clan_name"`
}

type clan struct {
	Clan_Id int `json:"clan_id"`
	Name    int `json:"name"`
}
