import { useContext } from "react";

import { AuthContext, authContextDataProps } from "../context/AuthContext";

export function userAuth(): authContextDataProps {
  const context = useContext(AuthContext);
  return context
}
