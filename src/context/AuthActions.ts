import { Dispatch } from "react";
import { AuthAction, ActionTypes } from "./AppReducer";
import axios from "axios";

export const login = async (
  dispatch: Dispatch<AuthAction>,
  email: string,
  password: string,
) => {
  try {
    dispatch({ type: ActionTypes.LOGIN_START });
    const data = axios.get();
  } catch (error) {
    // هنا سنتعامل مع الأخطاء
  }
};
