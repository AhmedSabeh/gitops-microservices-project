import React, { useEffect, useState } from 'react';
import axios from 'axios';

function App() {
  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState('');

  useEffect(() => {
    fetchTasks();
  }, []);

  const fetchTasks = async () => {
    const res = await axios.get('http://localhost:5000/tasks');
    setTasks(res.data);
  };

  const addTask = async () => {
    if (!title) return;
    await axios.post('http://localhost:5000/tasks', { id: Date.now(), title, completed: false });
    setTitle('');
    fetchTasks();
  };

  return (
    <div style={{ padding: '20px' }}>
      <h1>Taskify</h1>
      <input value={title} onChange={e => setTitle(e.target.value)} placeholder="New task"/>
      <button onClick={addTask}>Add</button>
      <ul>
        {tasks.map(task => (
          <li key={task.id}>{task.title} {task.completed ? '✅' : '❌'}</li>
        ))}
      </ul>
    </div>
  );
}

export default App;

