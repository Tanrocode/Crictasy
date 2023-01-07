const express = require('express');
const app = express();

app.get("/", (req, res) => {
    res.send("API REFERENCE TEST");
});

app.get("/players/:player", (req, res) => {
    let player = sample_data.find(Object.keys(dictionary["Player Name"]) === req.params.player)
})

async function getPlayer 