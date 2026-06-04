import axios from "axios";

const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_URL,
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
    "ngrok-skip-browser-warning": "true",
  },
});

apiClient.interceptors.request.use(
  (config) => {
    if (config.headers.Authorization) {
      console.log("Token override active for:", config.url);
      return config;
    }

    const token = localStorage.getItem("token");
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
      console.log("Token added to request:", config.url);
    } else {
      console.warn("No token found for:", config.url);
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
  overrideToken?: string, // ← أضف هذا المعامل
): Promise<T> {
  try {
    const response = await apiClient.request({
      url: endpoint,
      method,
      data,
      // ✅ إذا وُجد overrideToken استخدمه بدل توكن الموظف
      headers: overrideToken
        ? { Authorization: `Bearer ${overrideToken}` }
        : undefined,
    });

    return response.data as T;
  } catch (error) {
    console.error(`Request failed: ${method} ${endpoint}`, error);
    throw error;
  }
}

export const api = {
  get: <T>(endpoint: string) => request<T>(endpoint, "GET"),

  post: <T>(endpoint: string, data: any, overrideToken?: string) =>
    request<T>(endpoint, "POST", data, overrideToken), // ← أضف overrideToken

  put: <T>(endpoint: string, data?: any) => request<T>(endpoint, "PUT", data),

  delete: <T>(endpoint: string) => request<T>(endpoint, "DELETE"),
};

export { apiClient };
