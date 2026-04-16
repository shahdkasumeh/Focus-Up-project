import React from "react";
import { Room } from "../APIMethod/rooms";
import { Table } from "../APIMethod/tables";

//typescript
export interface User {
  id: string;
  email: string;
  full_name?: string;
  role?: string;
}

export interface AuthState {
  user: User | null;
  rooms: Room[];
  tables: Table[];
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
  rooms: [],
  tables: [],
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
  SET_ROOMS = "SET_ROOMS",
  ADD_ROOM = "ADD_ROOM",
  UPDATE_ROOM = "UPDATE_ROOM",
  DELETE_ROOM = "DELETE_ROOM",
  SET_TABLES = "SET_TABLES",
  DELETE_TABLES = "DELETE_TABLES",
  ADD_TABLE = "ADD_TABLE",
  UPDATE_TABLE = "UPDATE_TABLE",
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
    case ActionTypes.SET_ROOMS:
      return {
        ...state,
        rooms: action.payload,
      };

    case ActionTypes.ADD_ROOM:
      return {
        ...state,
        rooms: [action.payload, ...state.rooms],
      };

    case ActionTypes.UPDATE_ROOM:
      return {
        ...state,
        rooms: state.rooms.map((room) =>
          room.id === action.payload.id ? action.payload : room,
        ),
      };

    case ActionTypes.DELETE_ROOM:
      return {
        ...state,
        rooms: state.rooms.filter((room) => room.id !== action.payload),
      };

    case ActionTypes.SET_TABLES:
      return {
        ...state,
        tables: action.payload,
      };

    case ActionTypes.DELETE_TABLES:
      return {
        ...state,
        tables: state.tables.filter((table) => table.id !== action.payload),
      };
    case ActionTypes.ADD_TABLE:
      return {
        ...state,
        tables: [action.payload, ...state.tables],
      };

    case ActionTypes.UPDATE_TABLE:
      return {
        ...state,
        tables: state.tables.map((table) =>
          table.id === action.payload.id ? action.payload : table,
        ),
      };

    default:
      return state;
  }
};

export default AppReducer;
