import { useEffect, useState } from "react";

interface Character {
  character_id: number;
  name: string;
  age: number;
  clan_name: string;
}

function App() {
  const [data, setData] = useState<Character[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchCharacters = async () => {
      try {
        const res = await fetch(import.meta.env.VITE_API_URL);
        if (!res.ok) {
          throw new Error("Error al obtener los datos");
        }
        const json = await res.json();
        setData(json);
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
      } catch (err: any) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchCharacters();
  }, []);

  if (loading) return <p>Cargando...</p>;
  if (error) return <p style={{ color: "red" }}>{error}</p>;

  return (
    <div style={{ padding: "1rem" }}>
      <h1>Lista de personajes</h1>
      <ul>
        {data.map((ch) => (
          <li key={ch.character_id}>
            <strong>{ch.name}</strong> — {ch.age} años — Clan: {ch.clan_name}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
