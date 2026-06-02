import { statusCode, statusText } from "../helper/status";

export const statusApi = async (req: any, res: any) => {
  const code = statusCode.OK;

  res.status(code).json({
    status: "success",
    message: `API is working (${statusText[code]})`,
  });
};
