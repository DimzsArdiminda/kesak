import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import routes from "./routes/routes";
const app = express();


dotenv.config();
app.use(express.json());
app.use(routes);
app.use(cors());

const PORT = process.env.PORT;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
