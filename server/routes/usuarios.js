const express = require("express");
const bcrypt = require("bcrypt");
const connection = require("../config/database");
const router = express.Router();

router.get("/r_usuario", (req, res) => {
  connection.query("CALL USUARIOS_CRUD(?, NULL, NULL, NULL, NULL, NULL, NULL)", ['R'], (error, results, fields) => {
    if (error) {
      console.error("Error getting users:", error);
      res.status(500).json({ success: false, message: error.sqlMessage });
    } else {
      res.json({ success: true, data: results[0] });
    }
  });
});

router.post("/c_usuario", async (req, res) => {
  // console.log(req.body)
  const { IDUSUARIO, CONTRA, NOMBRES, APELLIDOS, IDESTADO, FOTO } = req.body;  
  const saltRounds = 10;
  const hCONTRA = await bcrypt.hash(CONTRA, saltRounds);

  connection.query("CALL USUARIOS_CRUD(?, ?, ?, ?, ?, ?, ?)", ['C', IDUSUARIO, hCONTRA, NOMBRES, APELLIDOS, IDESTADO, FOTO], (error, results, fields) => {
    if (error) {
      console.error("Error creating user:", error);
      res.status(500).json({ success: false, message: error });
    } else {
      res.json({ success: true, data: results[0] });
    }
  });
});

module.exports = router;