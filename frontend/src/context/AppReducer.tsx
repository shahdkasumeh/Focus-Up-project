import React from "react";
import { Room } from "../APIMethod/rooms";
import { Table } from "../APIMethod/tables";
import { AdminPackages } from "../APIMethod/packages";
import { BookingDetails } from "../APIMethod/bookings";
import { ReceptionPackages } from "../APIMethod/packages";
import { BookingRevenues } from "../APIMethod/bookings";
import { Prizes } from "../APIMethod/prizes";

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
  AdminPackages: AdminPackages[];
  ReceptionPackages: ReceptionPackages[];
  bookingDetails: BookingDetails[];
  isAuthenticated: boolean;
  loading: boolean;
  error: string | null;
  BookingRevenues: BookingRevenues | null;
  prizes: Prizes[];
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
  AdminPackages: [],
  ReceptionPackages: [],
  bookingDetails: [],
  isAuthenticated: !!initialUser,
  loading: false,
  error: null,
  BookingRevenues: null,
  prizes: [],
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
  SET_PACKAGE = "SET_PACKAGE",
  ADD_PACKAGE = "ADD_PACKAGE",
  UPDATE_PACKAGE = "UPDATE_PACKAGE",
  DELETE_PACKAGE = "DELETE_PACKAGE",
  SET_BOOKINGDETAILS = "SET_BOOKINGDETAILS",
  SET_RECEPTION_PACKAGE = "SET_RECEPTION_PACKAGE",
  UPDATE_RECEPTION_PACKAGE = "UPDATE_RECEPTION_PACKAGE",
  SET_BOOKING_REVENUES = "SET_BOOKING_REVENUES",
  SET_PRIZES = "SET_PRIZES",
  ADD_PRIZE = "ADD_PRIZE",
  UPDATE_PRIZE = "UPDATE_PRIZE",
  DELETE_PRIZE = "DELETE_PRIZE",
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

    case ActionTypes.SET_PACKAGE:
      return {
        ...state,
        AdminPackages: action.payload,
      };

    case ActionTypes.DELETE_PACKAGE:
      return {
        ...state,
        AdminPackages: state.AdminPackages.filter(
          (packages) => packages.id !== action.payload,
        ),
      };
    case ActionTypes.ADD_PACKAGE:
      return {
        ...state,
        AdminPackages: [action.payload, ...state.AdminPackages],
      };

    case ActionTypes.UPDATE_PACKAGE:
      return {
        ...state,
        AdminPackages: state.AdminPackages.map((packages) =>
          packages.id === action.payload.id ? action.payload : packages,
        ),
      };

    case ActionTypes.SET_BOOKINGDETAILS:
      return {
        ...state,
        bookingDetails: action.payload,
      };

    case ActionTypes.SET_RECEPTION_PACKAGE:
      return {
        ...state,
        ReceptionPackages: action.payload,
      };

    case ActionTypes.UPDATE_RECEPTION_PACKAGE:
      return {
        ...state,
        ReceptionPackages: state.ReceptionPackages.map((packages) =>
          packages.id === action.payload.id ? action.payload : packages,
        ),
      };
    case ActionTypes.SET_BOOKING_REVENUES:
      return {
        ...state,
        BookingRevenues: action.payload,
      };

    case ActionTypes.SET_PRIZES:
      return {
        ...state,
        prizes: action.payload,
      };

    case ActionTypes.DELETE_PRIZE:
      return {
        ...state,
        prizes: state.prizes.filter((prizes) => prizes.id !== action.payload),
      };
    case ActionTypes.ADD_PRIZE:
      return {
        ...state,
        prizes: [action.payload, ...state.prizes],
      };

    case ActionTypes.UPDATE_PRIZE:
      return {
        ...state,
        prizes: state.prizes.map((prizes) =>
          prizes.id === action.payload.id ? action.payload : prizes,
        ),
      };

    default:
      return state;
  }
};

export default AppReducer;
