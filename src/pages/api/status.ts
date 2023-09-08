import type { NextApiRequest, NextApiResponse } from "next";

const handler = (_req: NextApiRequest, res: NextApiResponse) => {
  return res.status(200).send({
    message: "OK"
  });
};

export default handler;
