import React, { useEffect, useState } from "react";

function App() {
  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState("");

  const API_URL = process.env.REACT_APP_API_URL || "http://localhost:8080";

  const fetchTasks = async () => {
    const res = await fetch(`${API_URL}/tasks`);
    const data = await res.json();
    setTasks(data);
  };

  const addTask = async () => {
    await fetch(`${API_URL}/tasks`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ title }),
    });
    setTitle("");
    fetchTasks();
  };

  const toggleTask = async (id, completed) => {
    await fetch(`${API_URL}/tasks/${id}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ completed: !completed }),
    });
    fetchTasks();
  };

  const deleteTask = async (id) => {
    await fetch(`${API_URL}/tasks/${id}`, { method: "DELETE" });
    fetchTasks();
  };

  useEffect(() => {
    fetchTasks();
  }, []);

  return (
    <div style={{ padding: 20 }}>
      <h1>📝 Taskify</h1>
      <input
        value={title}
        onChange={(e) => setTitle(e.target.value)}
        placeholder="New task"
      />
      <button onClick={addTask}>Add</button>
      <ul>
        {tasks.map((t) => (
          <li key={t.id}>
            <input
              type="checkbox"
              checked={t.completed}
              onChange={() => toggleTask(t.id, t.completed)}
            />
            {t.title}
            <button onClick={() => deleteTask(t.id)}>❌</button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;

