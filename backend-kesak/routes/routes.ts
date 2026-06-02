import express from "express";
import { statusApi } from "../controller/Controller";

const routes = express.Router();
routes.get("/", statusApi);

export default routes;