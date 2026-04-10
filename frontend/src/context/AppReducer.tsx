import React from "react";
//typescript
export interface User {
  id: string;
  email: string;
  full_name?: string;
  role_type?: string;
}

export interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  loading: boolean;
  error: string | null;
}

export interface AuthAction {
  type: ActionTypes;
  payload?: any;
  user?: User | null;
}

// eslint-disable-next-line react-refresh/only-export-components
const storedUser = localStorage.getItem("user");
const initialUser = storedUser ? JSON.parse(storedUser) : null;
export const initialState: AuthState = {
  user: initialUser,
  isAuthenticated: !!initialUser,
  loading: false,
  error: null,
};

// eslint-disable-next-line react-refresh/only-export-components
export enum ActionTypes {
  LOGIN_START = "LOGIN_START",
  LOGIN_SUCCESS = "LOGIN_SUCCESS",
  LOGIN_FAILURE = "LOGIN_FAILURE",
  LOGOUT = "LOGOUT",
  SET_USER = "SET_USER",
}

const AppReducer = (
  state: AuthState = initialState,
  action: AuthAction,
): AuthState => {
  switch (action.type) {
    case ActionTypes.LOGIN_START:
      return {
        ...state,
        loading: true,
        error: null,
      };

    case ActionTypes.SET_USER:
      localStorage.setItem("user", JSON.stringify(action.user));
      return {
        ...state,
        user: action.user || null,
        isAuthenticated: !!action.user,
        loading: false,
        error: null,
      };

    case ActionTypes.LOGIN_SUCCESS:
      return {
        ...state,
        loading: false,
        error: null,
      };

    case ActionTypes.LOGIN_FAILURE:
      return {
        ...state,
        loading: false,
        error: action.payload,
        isAuthenticated: false,
      };

    case ActionTypes.LOGOUT:
      return {
        ...state,
        user: null,
        isAuthenticated: false,
        loading: false,
        error: null,
      };

    default:
      return state;
  }
};

export default AppReducer;
