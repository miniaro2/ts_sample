// `src/ts/main.ts`

interface User {
  name: string;
  email: string;
}

const loadUsersButton = document.getElementById('loadUsersBtn');
const userTableBody = document.querySelector('#userTable tbody');

async function fetchAndDisplayUsers(): Promise<void> {
  try {
      // 중요: 요청 주소를 서블릿이 아닌 users_data.jsp로 변경!
      const response = await fetch('users_data.jsp'); 
      if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
      }
      const users: User[] = await response.json();

      if(userTableBody) userTableBody.innerHTML = '';

      users.forEach(user => {
          const row = document.createElement('tr');
          row.innerHTML = `
              <td>${user.name}</td>
              <td>${user.email}</td>
          `;
          userTableBody?.appendChild(row);
      });

  } catch (error) {
      console.error('사용자 데이터를 불러오는 데 실패했습니다:', error);
      if (userTableBody) {
        userTableBody.innerHTML = '<tr><td colspan="2">데이터를 불러올 수 없습니다.</td></tr>';
      }
  }
}

loadUsersButton?.addEventListener('click', fetchAndDisplayUsers);