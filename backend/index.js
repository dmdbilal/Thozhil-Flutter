const app = require('./app');
const db = require('./config/database');
const user = require('./model/userModel');
const userRoutes = require('./routes/userRoutes');
const jobRoutes = require('./routes/jobRoutes')
const bodyParser = require('body-parser');
require('dotenv').config();

const port = 7500;

app.use(bodyParser.json());

app.use('/',userRoutes);
app.use('/',jobRoutes);

app.listen(port,() => {
  console.log(`App running on ${port}`);
});