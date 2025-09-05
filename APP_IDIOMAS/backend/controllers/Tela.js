import Usuario from "./Usuario.js";

const user = new Usuario(1, "Gustavo", "teste@email.com", "123456",
  new Date("1999-05-12"), "Brasil", "Português"
);

console.log("Autenticado?", user.autenticar("123456")); // true
console.log("Autenticado?", user.autenticar("senhaErrada")); // false

user.atualizarPerfil({ nome: "Guga DJ", idiomaNativo: "Inglês" });
user.registrarLogin();

console.log(user);
