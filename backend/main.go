package main

import (
	"database/sql"
	"log"
	"os"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

type Character struct {
	Character_Id int    `json:"character_id"`
	Name         string `json:"name"`
	Age          int    `json:"age"`
	Clan_Name    string `json:"clan_name"`
}

type Clan struct {
	Clan_Id int `json:"clan_id"`
	Name    int `json:"name"`
}

func Conectar_DB() *sql.DB {
	driver := os.Getenv("DB_DRIVER")
	dsn := os.Getenv("DB_DSN")

	db, err := sql.Open(driver, dsn)
	if err != nil {
		log.Fatalf("Error al abrir la base de datos: %v", err)
	}

	if err := db.Ping(); err != nil {
		log.Fatalf("No se pudo conectar a la base de datos: %v", err)
	}
	log.Println("Conectado a la base de datos:", driver)

	return db
}

func main() {

	if err := godotenv.Load(); err != nil {
		log.Println("No se pudo cargar el archivo .env")
	}

	db := Conectar_DB()
	defer db.Close()

	app := fiber.New()

	allowedOrigins := map[string]bool{
		"http://localhost:5173":                 true, // desarrollo
		"http://docker.between-bytes.tech":      true, // producción
		"http://docker.between-bytes.tech:3000": true, // producción
	}

	app.Use(cors.New(cors.Config{
		AllowCredentials: true,
		AllowMethods:     "GET,POST,PUT,DELETE,PATCH,OPTIONS",
		AllowHeaders:     "Origin, Content-Type, Accept, Authorization",
		AllowOriginsFunc: func(origin string) bool {
			return allowedOrigins[origin]
		},
	}))

	// ==== RUTAS ====
	api := app.Group("/api")
	v1 := api.Group("/v1")

	v1.Get("/characters", getCharactersHandler(db))

	log.Fatal(app.Listen(":" + os.Getenv("PUERTO_API")))

}

func getCharactersHandler(db *sql.DB) fiber.Handler {
	return func(c *fiber.Ctx) error {
		rows, err := db.Query(`
			SELECT c.character_id, c.name, c.age, cl.name AS clan_name
			FROM character c
			LEFT JOIN clan cl ON c.clan_id = cl.clan_id
		`)
		if err != nil {
			return c.Status(500).JSON(fiber.Map{"error": "Error al consultar la base de datos"})
		}
		defer rows.Close()

		var characters []Character
		for rows.Next() {
			var ch Character
			if err := rows.Scan(&ch.Character_Id, &ch.Name, &ch.Age, &ch.Clan_Name); err != nil {
				return c.Status(500).JSON(fiber.Map{"error": "Error al leer los datos"})
			}
			characters = append(characters, ch)
		}

		return c.JSON(characters)
	}
}
