import React, { ReactNode, createContext, useContext, useReducer } from "react";
import AppReducer from "./AppReducer";
import { initialState, AuthState, AuthAction } from "./AppReducer";

interface GlobalContextType {
  state: AuthState;
  dispatch: React.Dispatch<AuthAction>;
}

const GlobalContext = createContext<GlobalContextType | undefined>(undefined);

interface GlobalStateProps {
  children: ReactNode;
}

const GlobalState = ({ children }: GlobalStateProps) => {
  const [state, dispatch] = useReducer(AppReducer, initialState);

  return (
    <GlobalContext.Provider value={{ state, dispatch }}>
      {children}
    </GlobalContext.Provider>
  );
};
export default GlobalState;

export const useAuth = (): GlobalContextType => {
  const context = useContext(GlobalContext);
  if (!context) {
    throw new Error("useAuth must be used within a GlobalState provider");
  }
  return context;
};
