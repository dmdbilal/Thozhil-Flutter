const mongoose = require('mongoose');
require('dotenv').config();

const uri = 'mongodb+srv://adibala1306:ThozhilApp@thozhil.1rfasie.mongodb.net/';

const conn = mongoose.createConnection(uri, {
    serverSelectionTimeoutMS: 30000,
    socketTimeoutMS: 45000
});


conn.on('connected', () => {
    console.log('MongoDB is connected');
});

conn.on('error', (err) => {
  console.error(`Mongoose connection error: ${err}`);
});

module.exports = conn;