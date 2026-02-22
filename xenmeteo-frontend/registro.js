document.getElementById("registerForm").addEventListener("submit", function(e) {

    e.preventDefault();

    const username = document.getElementById("username").value;
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    fetch("http://localhost:8080/api/auth/register", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            username: username,
            email: email,
            password: password
        })
    })
    .then(response => response.text())
    .then(data => {
        document.getElementById("mensaje").innerText = data;
    })
    .catch(error => {
        console.error("Error:", error);
    });

});