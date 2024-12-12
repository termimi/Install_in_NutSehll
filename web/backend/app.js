const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
const port = 3000;

app.use(cors());

const db = mysql.createConnection({
    host: "localhost",
    user: "root", 
    password: "root", 
    database: "Install_in_NutShell",
    port: 6033
});

db.connect((err) => {
    if (err) {
        console.error("Erreur de connexion à la base de données:", err);
        return;
    }
    console.log("Connecté à la base de données MySQL");
});

app.get("/download", (req, res) => {
    const query = "SELECT nom, contenu FROM Script_file";

    db.query(query, (err, results) => {
        if (err) {
            console.error("Erreur SQL :", err);
            return res.status(500).send(" Une erreur serveur");
        }

        if (results.length === 0) {
            return res.status(404).send("Aucun fichier trouvé");
        }

        console.log("aaaaaaaaaaaaa");
        const { nom, contenu } = results[0];
        console.log(results[0])


        const contenuTexte = Buffer.from(contenu).toString("utf-8");

        
        res.setHeader("Content-Type", "application/octet-stream");
        res.setHeader("Content-Disposition", `attachment; filename="${nom}.ps1"`);
        res.send(contenuTexte);
    });
});
;

app.listen(port, () => {
    console.log(`Serveur démarré sur http://localhost:${port}`);
});
