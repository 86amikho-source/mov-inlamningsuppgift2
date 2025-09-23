const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;
const APP_NAME = process.env.APP_NAME || 'MOV Inlämningsuppgift 2';

app.get('/', (req, res) => {
  res.send(`
    <html>
      <head><meta charset="utf-8"><title>${APP_NAME}</title></head>
      <body style="font-family: sans-serif;">
        <h1>${APP_NAME}</h1>
        <p>Hej! Din container körs. Tid: ${new Date().toISOString()}</p>
        <p>Miljövariabel <code>APP_NAME</code> kan styra rubriken.</p>
      </body>
    </html>
  `);
});

app.get('/healthz', (req, res) => res.status(200).send('ok'));
app.listen(PORT, () => console.log(`Server lyssnar på port ${PORT}`));
