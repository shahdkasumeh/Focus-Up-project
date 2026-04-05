import React from "react";
//typescript
export interface User {
  id: string;
  email: string;
  name?: string;
  role?: string;
}

export interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  loading: boolean;
  error: string | null;
}

// تعريف شكل الـ Action
export interface AuthAction {
  type: ActionTypes;
  payload?: any;
  user?: User | null;
}

// الحالة الأولية
// eslint-disable-next-line react-refresh/only-export-components
export const initialState: AuthState = {
  user: null,
  isAuthenticated: false,
  loading: false,
  error: null,
};

// أنواع الإجراءات (Actions)
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

    case ActionTypes.LOGIN_SUCCESS:
      return {
        ...state,
        user: action.payload,
        isAuthenticated: true,
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

    case ActionTypes.SET_USER:
      return {
        ...state,
        user: action.user || null,
        isAuthenticated: !!action.user,
      };

    default:
      return state;
  }
};

export default AppReducer;
