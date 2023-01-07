require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const app = express();
const port = 3000


async function main() {
    await mongoose.connect(process.env.CONNECT_STRING);
}

const statRouter = require("./routes/stats")
app.use("/api")

app.listen(port, () => {
    
    console.log(`Example app listening at http://localhost:${port}`)
});


