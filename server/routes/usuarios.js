const express = require("express");
const connection = require("../config/database");
const router = express.Router();

router.get("/listarUsuarios", (req, res) => {
  connection.query("CALL USUARIOS_CRUD(?, NULL, NULL, NULL, NULL, NULL, NULL)", ['R'], (error, results, fields) => {
    if (error) {
      console.error("Error getting users:", error);
      res.status(500).json({ success: false, message: error.sqlMessage });
    } else {
      res.json({ success: true, data: results[0] });
    }
  });
});

module.exports = router;