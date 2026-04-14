import { api } from "./client";

export interface User {
  id: string;
  email: string;
  name?: string;
  role: "admin" | "receptionist" | "user";
}

export interface LoginResponse {
  user: User;
  token?: string;
  message?: string;
}

export interface LoginCredentials {
  email: string;
  password: string;
}

export const authApi = {
  login: (credentials: LoginCredentials): Promise<LoginResponse> => {
    return api.post<LoginResponse>("/login", credentials);
  },
};
