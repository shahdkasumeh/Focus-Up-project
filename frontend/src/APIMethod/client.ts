import axios from "axios";

const apiClient = axios.create({
  baseURL: "http://127.0.0.1:8000/api",
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
  },
});

apiClient.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem("token");
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
      console.log(" Token added to request:", config.url);
    } else {
      console.warn(" No token found for:", config.url);
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  },
);

apiClient.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    if (error.response?.status === 401) {
      console.error(" Unauthorized! Logging out...");
      localStorage.removeItem("token");
      localStorage.removeItem("user");
      window.location.href = "/login";
    } else if (error.response?.status === 405) {
      console.error(" Method not allowed:", error.config?.url);
    } else if (error.response?.status === 422) {
      console.error(" Validation error:", error.response?.data);
    }

    return Promise.reject(error);
  },
);

async function request<T>(
  endpoint: string,
  method: string = "GET",
  data?: any,
): Promise<T> {
  try {
    const response = await apiClient.request({
      url: endpoint,
      method,
      data,
    });

    return response.data as T;
  } catch (error) {
    console.error(` Request failed: ${method} ${endpoint}`, error);
    throw error;
  }
}

export const api = {
  get: <T>(endpoint: string) => request<T>(endpoint, "GET"),
  post: <T>(endpoint: string, data: any) => request<T>(endpoint, "POST", data),
  put: <T>(endpoint: string, data: any) => request<T>(endpoint, "PUT", data),
  delete: <T>(endpoint: string) => request<T>(endpoint, "DELETE"),
};

export { apiClient };
